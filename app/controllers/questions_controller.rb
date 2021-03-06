class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :destroy, :validate, :lists]
  before_action :set_breadcrumb, only: [:new, :edit]
  before_action :set_question, only: [:edit, :update, :category_reference, :destroy, :dependencies]

  def new
    add_breadcrumb t('breadcrumbs.new')

    @question = Question.new
    authorize @question
    @question.type = nil # To resolve issue that prevents to display the prompt in the form
  end

  def edit
    add_breadcrumb @question.label
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    authorize policy_scope(Question)
    ActiveRecord::Base.transaction(requires_new: true) do
      question = @algorithm.questions.new(question_params)
      question.becomes(Object.const_get(question_params[:type])) if question_params[:type].present?
      question.unavailable = question_params[:unavailable] if question.is_a? Questions::AssessmentTest # Manually done it because the form could not handle it

      question.answers.map { |f| f.node = question } # No idea Why we have to do this

      # in order to add answers after creation (which can't be done if the question has no id), we also remove reference from params so it will not fail validation
      if question.validate_overlap && question.save
        if params[:from] == 'rails'
          render json: {url: algorithm_url(@algorithm, panel: 'questions')}
        else
          instanceable = Object.const_get(params[:instanceable_type].camelize.singularize).find(params[:instanceable_id])
          instance = instanceable.components.create!(node: question, final_diagnosis_id: params[:final_diagnosis_id])
          render json: instance.generate_json
        end
      else
        render json: question.errors.full_messages, status: 422
        raise ActiveRecord::Rollback, ''
      end
    end
  end

  def update
    ActiveRecord::Base.transaction(requires_new: true) do
      if @question.update(question_params) && @question.validate_overlap
        if params[:from] == 'rails'
          render json: {url: algorithm_url(@algorithm, panel: 'questions')}
        else
          render json: @question.as_json(include: [:answers, :complaint_categories, :medias], methods: [:node_type, :category_name, :type])
        end

      else
        render json: @question.errors.full_messages, status: 422
        raise ActiveRecord::Rollback, ''
      end
    end
  end

  def destroy
    # If user remove 'disabled' css in button, we verify in controller
    if @question.dependencies?
      redirect_to algorithm_url(@algorithm, panel: 'questions'), alert: t('dependencies')
    else
      if @question.destroy
        redirect_to algorithm_url(@algorithm, panel: 'questions'), notice: t('flash_message.success_updated')
      else
        redirect_to algorithm_url(@algorithm, panel: 'questions'), alert: t('error')
      end
    end
  end

  # GET questions/:id/dependencies
  # @params question [Node] question
  # @return Dependencies for the given question
  def dependencies
    authorize policy_scope(Question)
    render json: @question.diagnoses.map(&:reference_label) + @question.dependencies.map(&:instanceable).flatten.map(&:reference_label)
  end

  # GET questions/dependencies
  # Return several attributes of the model Question to build dropdown lists
  def lists
    authorize policy_scope(Question)
    render json: Question.list_attributes(params[:diagram_type], @algorithm)
  end

  # GET questions/reference_prefix/:type
  # @params Category of Question
  # Return class name according to the param
  def reference_prefix
    authorize policy_scope(Question)
    render json: Question.reference_prefix_class(params[:type])
  end

  # POST algorithms/:algorithm_id/questions/:id/validate
  # @params question [Question] question to be validated
  # Validate the question with its formula, its answers and its fields
  def validate
    authorize policy_scope(Question)
    question = @algorithm.questions.new(question_params)
    question.validate_formula
    question.validate_ranges

    if question.valid?
      render json: {}, status: 200
    else
      render json: question.errors.messages, status: 422
    end
  end

  private

  def set_breadcrumb
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'questions')
    add_breadcrumb t('breadcrumbs.questions')
  end

  def set_question
    @question = Node.find(params[:id])
    authorize @question
  end

  def question_params
    question_param = params.require(:question).permit(
      :id,
      Language.language_params('label'),
      :reference,
      :is_mandatory,
      :system,
      :stage,
      :type,
      Language.language_params('description'),
      :answer_type_id,
      :answer_type,
      :unavailable,
      :formula,
      :snomed_id,
      :snomed_label,
      :is_triage,
      :is_identifiable,
      :is_pre_fill,
      :min_value_warning,
      :max_value_warning,
      :min_value_error,
      :max_value_error,
      Language.language_params('min_message_warning'),
      Language.language_params('max_message_warning'),
      Language.language_params('min_message_error'),
      Language.language_params('max_message_error'),
      :round,
      :estimable,
      :is_neonat,
      :is_danger_sign,
      :emergency_status,
      Language.language_params('placeholder'),
      complaint_category_ids: [],
      answers_attributes: [
        :id,
        :reference,
        Language.language_params('label'),
        :operator,
        :value,
        :_destroy
      ],
      medias_attributes: [
        :id,
        Language.language_params('label'),
        :filename,
        :url,
        :fileable,
        :_destroy
      ]
    )
    question_param.merge(convert_data_uri_to_upload(question_param))
    question_param
  end

  # Convert file from react to put in Carrierwave compliant format
  def convert_data_uri_to_upload(obj_hash)
    obj_hash["medias_attributes"].each do |media|
      if media[:url].try(:match, %r{^data:(.*?);(.*?),(.*)$})
        image_data = split_base64(media[:url])
        image_data_string = image_data[:data]
        image_data_binary = Base64.decode64(image_data_string)
        temp_img_file = Tempfile.new(media["filename"])
        temp_img_file.binmode
        temp_img_file << image_data_binary
        temp_img_file.rewind

        img_params = {filename: media["filename"], headers: [], type: image_data[:type], tempfile: temp_img_file}
        uploaded_file = ActionDispatch::Http::UploadedFile.new(img_params)
        media.delete(:url)
        media.delete(:filename)
        media[:url] = uploaded_file
      end
    end

    obj_hash
  end

  # Extract base64 data
  def split_base64(uri_str)
    if uri_str.match(%r{^data:(.*?);(.*?),(.*)$})
      uri = Hash.new
      uri[:type] = $1 # "image/gif"
      uri[:encoder] = $2 # "base64"
      uri[:data] = $3 # data string
      uri[:extension] = $1.split('/')[1] # "gif"
      uri
    else
      nil
    end
  end
end
