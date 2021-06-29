class VersionsController < ApplicationController
  before_action :authenticate_user!, except: [:change_triage_order, :change_systems_order]
  before_action :set_algorithm, only: [:index, :show, :new, :create, :edit, :update, :archive, :unarchive, :duplicate, :create_triage_condition, :set_medal_data_config, :remove_triage_condition, :final_diagnoses_exclusions, :generate_translations, :generate_variables, :final_diagnoses, :import_translations, :job_status, :update_full_order, :list]
  before_action :set_breadcrumb, only: [:show, :new, :edit]
  before_action :set_version, only: [:show, :edit, :update, :archive, :unarchive, :change_triage_order, :change_systems_order, :components, :create_triage_condition, :set_medal_data_config, :duplicate, :remove_components, :remove_triage_condition, :update_list, :regenerate_json, :final_diagnoses_exclusions, :generate_translations, :generate_variables, :final_diagnoses, :import_translations, :job_status, :update_full_order, :registration_triage_questions, :medal_data_config, :full_order, :translations]

  def index
    authorize policy_scope(Version)
    respond_to do |format|
      format.html
      format.js { }
      format.json { render json: VersionDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    add_breadcrumb @version.name
  end

  def new
    add_breadcrumb t('breadcrumbs.new')

    @version = Version.new
    authorize @algorithm
  end

  def edit
    add_breadcrumb @version.name, algorithm_version_url(@algorithm, @version)
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    @version = @algorithm.versions.new(version_params)
    @version.user = current_user
    authorize @version

    if @version.save
      redirect_to algorithm_url(@algorithm, panel: 'versions'), notice: t('flash_message.success_created')
    else
      set_breadcrumb
      add_breadcrumb t('breadcrumbs.new')
      render :new
    end
  end

  def update
    if @version.update(version_params)
      redirect_to algorithm_url(@algorithm, panel: 'versions'), notice: t('flash_message.success_updated')
    else
      set_breadcrumb
      add_breadcrumb t('breadcrumbs.edit')
      render :edit
    end
  end

  # PUT algorithms/:algorithm_id/version/:id/archive
  # @params version [Version] version of algorithm to archive
  # @return redirect to versions#index with flash message
  # Archive the given algorithm version.
  def archive
    @version.archived = true

    if @version.save
      flash[:notice] = t('flash_message.success_archive')
      render json: { status: 'success' }
    else
      flash[:alert] = t('flash_message.update_fail')
      render json: { status: 'failed' }
    end
  end

  # PUT algorithms/:algorithm_id/version/:id/change_triage_order
  # @params version [Version] version of algorithm we change order of
  # Change the order of the triage questions for this version
  def change_triage_order
    config = @version.medal_r_config
    config['questions_orders'][params[:key]] = params[:order].map(&:to_i)
    if @version.update(medal_r_config: config)
      render json: {result: 'success'}
    else
      render json: {result: 'error'}
    end
  end

  # PUT algorithms/:algorithm_id/version/:id/change_triage_order
  # @params version [Version] version of algorithm we change order of
  # Change the order of the triage questions for this version
  def change_systems_order
    config = @version.medal_r_config
    config['systems_order'] = params[:order]
    if @version.update(medal_r_config: config)
      render json: {result: 'success'}
    else
      render json: {result: 'error'}
    end
  end

  # PUT algorithms/:algorithm_id/version/:id/components
  # Instantiate nodes in the version
  def components
    params[:nodes_ids].map do |node_id|
      @version.components.create(node_id: node_id)
    end
  end

  # PUT algorithms/:algorithm_id/version/:id/create_triage_condition
  # @params version [Version] version of algorithm where we create a condition
  # @params id of the triage question to put the condition on
  # @params id of the complaint category that condition the triage question
  # Create a condition between a triage question and a complaint category
  def create_triage_condition
    if version_params[:cc_id].blank?
      redirect_to algorithm_version_url(@algorithm, @version, panel: 'triage_conditions'), alert: t('flash_message.version.complaint_category_missing')
    elsif version_params[:triage_id].blank?
      redirect_to algorithm_version_url(@algorithm, @version, panel: 'triage_conditions'), alert: t('flash_message.version.triage_question_missing')
    else
      instance = Instance.find(version_params[:triage_id])
      cc_answer = Instance.find(version_params[:cc_id]).node.answers.first

      condition = Condition.new(instance: instance, answer: cc_answer)

      if condition.save
        redirect_to algorithm_version_url(@algorithm, @version, panel: 'triage_conditions'), notice: t('flash_message.success_created')
      else
        redirect_to algorithm_version_url(@algorithm, @version, panel: 'triage_conditions'), alert: t('flash_message.create_fail')
      end
    end
  end

  # @params [Version] version to duplicate
  # Duplicate a version with every diagnoses and their logics (Instances with their Conditions and Children), the FinalDiagnoses and Conditions attached to it
  def duplicate
    job_id = DuplicateVersionJob.perform_later(@version.id)
    @version.update(job_id: job_id.provider_job_id)
    render json: { success: true, job_id: job_id }
  end

  # GET algorithms/:algorithm_id/version/:id/final_diagnoses
  # @params version [Version] version
  # Get every final diagnoses for a version
  def final_diagnoses
    authorize policy_scope(Version)
    respond_to do |format|
      format.html
      format.js { }
      format.json { render json: VersionFinalDiagnosisDatatable.new(params, view_context: view_context) }
    end
  end

  # GET algorithms/:algorithm_id/version/:id/final_diagnoses_exclusions
  # @params version [Version] version
  # Get every final diagnoses exclusions for a version
  def final_diagnoses_exclusions
    authorize policy_scope(Version)
    respond_to do |format|
      format.js { }
      format.json { render json: FinalDiagnosisExclusionDatatable.new(params, view_context: view_context) }
    end
  end

  # @params algorithm [Algorithm] current algorithm
  # @return json of drugs
  # All managements exclusions
  def registration_triage_questions
    respond_to do |format|
      format.js { }
    end
  end

  # @params algorithm [Algorithm] current algorithm
  # @return json of drugs
  # All managements exclusions
  def medal_data_config
    respond_to do |format|
      format.js { }
    end
  end

  # @params algorithm [Algorithm] current algorithm
  # @return json of drugs
  # All managements exclusions
  def full_order
    respond_to do |format|
      format.js { }
    end
  end

  # @params algorithm [Algorithm] current algorithm
  # @return json of drugs
  # All managements exclusions
  def translations
    respond_to do |format|
      format.js { }
    end
  end

  # GET algorithms/:algorithm_id/version/:id/generate_translations
  # @params version [Version] version
  # Get an excel export of all translatable labels used by the version
  def generate_translations
    respond_to do |format|
      format.xlsx
    end
  end

  # GET algorithms/:algorithm_id/version/:id/generate_variables
  # @params version [Version] version
  # Get an excel export of variables and final diagnoses used by the version
  def generate_variables
    authorize policy_scope(Version)
    respond_to do |format|
      format.xlsx
    end
  end

  # PUT algorithms/:algorithm_id/version/:id/import_translations
  # @params version [Version] version
  # Import an excel file to parse all nodes and update their labels/descriptions translations
  def import_translations
    authorize policy_scope(Version)
    file = params[:version][:file]
    if file.present? && File.extname(file.original_filename).include?('xls')
      xl_file = Roo::Spreadsheet.open(file.path, extension: :xlsx)

      ActiveRecord::Base.transaction(requires_new: true) do
        begin
          update_translations(Diagnosis, Diagnosis.get_translatable_params(xl_file.sheet(0)), xl_file.sheet(0))
          update_translations(FinalDiagnosis, Node.get_translatable_params(xl_file.sheet(1)), xl_file.sheet(1))
          update_translations(Question, Node.get_translatable_params(xl_file.sheet(2)), xl_file.sheet(2))
          update_translations(Answer, Answer.get_translatable_params(xl_file.sheet(2)), xl_file.sheet(2))
          update_translations(HealthCares::Drug, Node.get_translatable_params(xl_file.sheet(3)), xl_file.sheet(3))
          update_translations(Formulation, Formulation.get_translatable_params(xl_file.sheet(3)), xl_file.sheet(3))
          update_translations(HealthCares::Management, Node.get_translatable_params(xl_file.sheet(4)), xl_file.sheet(4))

          redirect_to algorithm_version_url(@algorithm, @version, panel: 'translations'), notice: t('flash_message.import_successful')
        rescue
          redirect_to algorithm_version_url(@algorithm, @version, panel: 'translations'), alert: t('flash_message.import_xl_error')
          raise ActiveRecord::Rollback, ''
        end
      end
    else
      redirect_to algorithm_version_url(@algorithm, @version, panel: 'translations'), alert: t('flash_message.import_xl_wrong_file')
    end

  end

  # GET algorithms/:algorithm_id/version/:id/job_status
  # Checks the status of the ongoing background job and returns the correct status and message
  def job_status
    status = Sidekiq::Status::status(@version.job_id)
    if [:complete, :failed, :interrupted].include?(status)
      @version.update(job_id: "")
    end
    render json: { job_status: status }
  end

  # GET algorithms/:algorithm_id/versions/list
  # @params algorithm_id [Integer]
  # Generate versions list json
  def list
    authorize policy_scope(Version)
    render json: @algorithm.versions.as_json(methods: :display_archive_status)
  end

  # PUT algorithms/:algorithm_id/version/:id/regenerate_json
  # @params version [Version] version
  # Generate json for the version
  def regenerate_json
    invalid_diagnoses = []

    if @version.algorithm.village_json.nil?
      render json: { success: false, message: t('flash_message.version.missing_villages') } and return
    end

    @version.diagnoses.each do |diagnosis|
      diagnosis.manual_validate
      invalid_diagnoses.push(diagnosis.full_reference) if diagnosis.errors.messages.any?
    end

    if invalid_diagnoses.any?
      render json: { success: false, message: t('flash_message.version.invalids_diagnoses', diagnoses: invalid_diagnoses) }
    else
      components_count = @version.components.count
      questions_orders = []
      @version.medal_r_config['questions_orders'].map do |key, value|
        questions_orders += value
      end

      if components_count != questions_orders.count
        render json: { success: false, message: t('flash_message.version_components_data_error') }
      else
        missing_nodes = Node.where(id: @version.identify_missing_questions)
        if missing_nodes.any?
          render json: { success: false, message: t('flash_message.missing_nodes_error', missing_nodes: missing_nodes.map(&:reference_label)) }
        else
          job_id = GenerateJsonJob.perform_later(@version.id)
          @version.update(job_id: job_id.provider_job_id)
          render json: { success: true, version: @version.reload }
        end
      end
    end
  end

  # PUT algorithms/:algorithm_id/version/:id/remove_components
  # Remove instantiated nodes from the version
  def remove_components
    params[:nodes_ids].map do |node_id|
      instance = @version.components.find_by(node_id: node_id)
      instance.destroy if instance.present?
    end
  end

  # Remove a condition between a triage question and a complaint category
  def remove_triage_condition
    condition = Condition.find(params[:condition_id])

    if condition.destroy
      redirect_to algorithm_version_url(@algorithm, @version, panel: 'triage_conditions'), notice: t('flash_message.success_created')
    else
      redirect_to algorithm_version_url(@algorithm, @version, panel: 'triage_conditions'), notice: t('flash_message.create_fail')
    end
  end

  # Update MedAL-data config with the automatic questions.
  def set_medal_data_config
    @version.medal_data_config = params['set_medal_data_config']

    if @version.save
      redirect_to algorithm_version_url(@algorithm, @version, panel: 'medal_data_config'), notice: t('flash_message.success_updated')
    else
      redirect_to algorithm_version_url(@algorithm, @version, panel: 'medal_data_config'), notice: t('flash_message.update_fail')
    end
  end

  # PUT algorithms/:algorithm_id/version/:id/unarchive
  # @params version [Version] version to archive
  # @return redirect to algorithms#index with flash message
  # Unarchive an algorithm version.
  def unarchive
    @version.archived = false

    if @version.save
      flash[:notice] = t('flash_message.success_unarchive')
      render json: { status: 'success' }
    else
      flash[:alert] = t('flash_message.update_fail')
      render json: { status: 'failed' }
    end
  end

  def update_full_order
    if @version.update(full_order_json: version_params[:full_order_json])
      render json: {result: 'success'}
    else
      render json: {result: 'error'}
    end
  end

  # PUT algorithms/:algorithm_id/version/:id/update_list
  # @params version [Version]
  # @params new order [Hash]
  # @params list type [String]
  # Update patient_list_order or medical_case_list_order
  def update_list
    config = @version.medal_r_config
    config["#{params[:list]}_list_order"] = params[:order]
    @version.update(medal_r_config: config)
  end

  private

  # Generic method to update translations for a given model with a given ID from excel sheet
  def update_translations(model, params, data)
    data.each_with_index do |row, index|
      if index != 0 && row[1] == model.to_s
        diagnosis = model.find(row[0])
        unless diagnosis.nil?
          diagnosis_params = {}
          params.map do |field, col|
            diagnosis_params[field] = row[col]
          end

          diagnosis.update(diagnosis_params)
        end
      end
    end
  end

  def set_breadcrumb
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'versions')
    add_breadcrumb t('breadcrumbs.versions')
  end

  def set_version
    @version = Version.find(params[:id])
    authorize @version
  end

  def version_params
    params.require(:version).permit(
      :id,
      :name,
      :description_en,
      :triage_unique_triage_question_order,
      :triage_complaint_category_order,
      :triage_basic_measurement_order,
      :triage_chronic_condition_order,
      :triage_questions_order,
      :triage_id,
      :cc_id,
      :top_left_question_id,
      :first_top_right_question_id,
      :second_top_right_question_id,
      :is_arm_control,
      :nodes_ids,
      :full_order_json,
      language_ids: []
    )
  end
end
