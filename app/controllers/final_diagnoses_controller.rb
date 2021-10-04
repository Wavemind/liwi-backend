class FinalDiagnosesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :destroy, :remove_exclusion, :add_exclusion]
  before_action :set_diagnosis, only: [:new, :create, :edit, :update, :destroy, :diagram]
  before_action :set_final_diagnosis, only: [:edit, :update, :destroy, :diagram]
  before_action :set_version, only: [:new, :create, :edit, :update, :destroy, :remove_exclusion, :add_exclusion]
  before_action :set_breadcrumb, only: [:new, :edit]
  layout 'diagram', only: [:diagram]

  def index
    authorize policy_scope(FinalDiagnosis)
    respond_to do |format|
      format.html
      format.json { render json: FinalDiagnosisDatatable.new(params, view_context: view_context) }
    end
  end

  def new
    add_breadcrumb @diagnosis.label, algorithm_version_diagnosis_url(@algorithm, @version, @diagnosis, panel: 'final_diagnoses')
    add_breadcrumb t('breadcrumbs.new')

    @final_diagnosis = FinalDiagnosis.new
    authorize @final_diagnosis
  end

  def edit
    add_breadcrumb @diagnosis.label, algorithm_version_diagnosis_url(@algorithm, @version, @diagnosis, panel: 'final_diagnoses')
    add_breadcrumb t('breadcrumbs.final_diagnoses')
    add_breadcrumb @final_diagnosis.label
    add_breadcrumb t('breadcrumbs.edit')

    @source = params[:source]
  end

  def create
    @final_diagnosis = @diagnosis.final_diagnoses.new(final_diagnosis_params)
    authorize @final_diagnosis

    if @final_diagnosis.save
      @diagnosis.components.create!(node: @final_diagnosis)
      if params[:from] == 'rails'
        render json: { url: algorithm_version_diagnosis_url(@algorithm, @version, @diagnosis, panel: 'final_diagnoses'), finalDiagnosis: @final_diagnosis }
      else
        render json: @final_diagnosis.get_instance_json
      end
    else
      render json: @final_diagnosis.errors.full_messages, status: 422
    end
  end

  def update
    if @final_diagnosis.update(final_diagnosis_params)
      if params[:from] == 'rails'
        if params[:source] === 'version'
          render json: { url: algorithm_version_url(@algorithm, @version, panel: 'final_diagnoses'), finalDiagnosis: @final_diagnosis }
        else
          render json: { url: algorithm_version_diagnosis_url(@algorithm, @version, @diagnosis, panel: 'final_diagnoses'), finalDiagnosis: @final_diagnosis }
        end
      else
        render json: @final_diagnosis.as_json(methods: [:node_type], include: :medias)
      end
    else
      render json: @final_diagnosis.errors.full_messages, status: 422
    end
  end

  def destroy
    # If user remove 'disabled' css in button, we verify in controller
    if @final_diagnosis.dependencies?
      redirect_to algorithm_version_diagnosis_url(@algorithm, @version, @diagnosis, panel: 'final_diagnoses'), alert: t('dependencies')
    else
      if @final_diagnosis.destroy
        redirect_to algorithm_version_diagnosis_url(@algorithm, @version, @diagnosis, panel: 'final_diagnoses'), notice: t('flash_message.success_updated')
      else
        redirect_to algorithm_version_diagnosis_url(@algorithm, @version, @diagnosis, panel: 'final_diagnoses'), alert: t('error')
      end
    end
  end

  # POST /algorithms/:algorithm_id/versions/:version_id/final_diagnoses/add_excluded_diagnosis
  # @params [FinalDiagnosis] excluding final diagnosis
  # @params [FinalDiagnosis] excluded final diagnosis
  # Exclude a final diagnosis from another
  def add_exclusion
    authorize policy_scope(FinalDiagnosis)
    @final_diagnosis_exclusion = NodeExclusion.new(final_diagnosis_exclusion_params)
    @final_diagnosis_exclusion.node_type = :final_diagnosis
    if @final_diagnosis_exclusion.save
      respond_to do |format|
        format.html { redirect_to algorithm_version_url(@algorithm.id, @version.id, panel: 'final_diagnoses_exclusions'), notice: t('flash_message.success_updated') }
        format.json { render json: @final_diagnosis_exclusion.excluding_node }
      end
    else
      respond_to do |format|
        format.html { redirect_to algorithm_version_url(@algorithm, @version, panel: 'final_diagnoses_exclusions'), alert: @final_diagnosis_exclusion.errors.full_messages }
        format.json { render json: @final_diagnosis_exclusion.errors.full_messages, status: 422 }
      end
    end
  end

  # GET algorithms/:algorithm_id/versions/:version_id/diagnoses/:diagnosis_id/final_diagnoses/:id/diagram
  # Render the diagram view
  def diagram
    authorize policy_scope(FinalDiagnosis)
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @final_diagnosis.diagnosis.version.algorithm.name, algorithm_url(@final_diagnosis.diagnosis.version.algorithm)
    add_breadcrumb "#{t('breadcrumbs.versions')} : #{@final_diagnosis.diagnosis.version.name}", algorithm_version_url(@final_diagnosis.diagnosis.version.algorithm, @final_diagnosis.diagnosis.version)
    add_breadcrumb t('breadcrumbs.diagnoses')
    add_breadcrumb @diagnosis.label_en, algorithm_version_diagnosis_url(@final_diagnosis.diagnosis.version.algorithm, @final_diagnosis.diagnosis.version, @diagnosis, panel: 'final_diagnoses')
  end

  # DELETE /algorithms/:algorithm_id/versions/:version_id/diagnoses/:diagnosis_id/final_diagnoses/remove_excluded_diagnosis
  # @params [FinalDiagnosis] excluding final diagnosis
  # @params [FinalDiagnosis] excluded final diagnosis
  # Remove exclusion between the two final diagnoses
  def remove_exclusion
    authorize policy_scope(FinalDiagnosis)
    @final_diagnosis_exclusion = NodeExclusion.final_diagnosis.find_by(final_diagnosis_exclusion_params)
    if @final_diagnosis_exclusion.destroy
      respond_to do |format|
        format.html { redirect_to algorithm_version_url(@algorithm.id, @version.id, panel: 'final_diagnoses_exclusions'), notice: t('flash_message.success_updated') }
        format.json { render json: @final_diagnosis_exclusion.excluding_node }
      end
    else
      respond_to do |format|
        format.html { redirect_to algorithm_version_url(@algorithm, @version, panel: 'final_diagnoses_exclusions'), alert: t('error') }
        format.json { render json: @final_diagnosis_exclusion.errors.full_messages, status: 422 }
      end
    end
  end

  private

  def set_breadcrumb
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
    add_breadcrumb t('breadcrumbs.versions')
    add_breadcrumb @version.name, algorithm_version_url(@algorithm, @version)
    add_breadcrumb t('breadcrumbs.diagnoses')
  end

  def set_diagnosis
    @diagnosis = Diagnosis.find(params[:diagnosis_id])
  end

  def set_final_diagnosis
    @final_diagnosis = Node.find(params[:id])
    authorize @final_diagnosis
  end

  def final_diagnosis_params
    final_diagnosis_param = params.require(:final_diagnosis).permit(
      :id,
      :reference,
      :label_en,
      :level_of_urgency,
      Language.language_params('label'),
      :description_en,
      Language.language_params('description'),
      medias_attributes: [
          :id,
          :label_en,
          Language.language_params('label'),
          :filename,
          :url,
          :fileable,
          :_destroy
      ]
    )
    final_diagnosis_param.merge(convert_data_uri_to_upload(final_diagnosis_param))
    final_diagnosis_param
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

  def final_diagnosis_exclusion_params
    params.require(:node_exclusion).permit(
      :excluding_node_id,
      :excluded_node_id
    )
  end
end
