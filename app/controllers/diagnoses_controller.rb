class DiagnosesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:show, :new, :create, :edit, :update, :destroy, :duplicate]
  before_action :set_version, only: [:show, :new, :create, :edit, :update, :destroy, :duplicate]
  before_action :set_diagnosis, only: [:show, :edit, :update, :diagram, :health_cares_diagram, :validate]
  before_action :set_breadcrumb, only: [:show, :new, :edit]
  layout 'diagram', only: [:diagram]

  def index
    authorize policy_scope(Diagnosis)
    respond_to do |format|
      format.html
      format.json {render json: DiagnosisDatatable.new(params, view_context: view_context)}
    end
  end

  def show
    add_breadcrumb @diagnosis.label

    @instance = Instance.new
    @instanceable = @diagnosis

    @final_diagnosis = FinalDiagnosis.new
  end

  def new
    add_breadcrumb t('breadcrumbs.new')

    @diagnosis = Diagnosis.new
    authorize @diagnosis
  end

  def edit
    add_breadcrumb @diagnosis.label, algorithm_version_diagnosis_url(@algorithm, @version, @diagnosis)
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    @diagnosis = @version.diagnoses.new(diagnosis_params)
    authorize @diagnosis

    if @diagnosis.save
      redirect_to algorithm_version_diagnosis_url(@algorithm, @version, @diagnosis), notice: t('flash_message.success_created')
    else
      set_breadcrumb
      add_breadcrumb t('breadcrumbs.new')
      render :new
    end
  end

  def update
    if @diagnosis.update(diagnosis_params)
      redirect_to algorithm_version_diagnosis_url(@algorithm, @version, @diagnosis), notice: t('flash_message.success_updated')
    else
      set_breadcrumb
      add_breadcrumb t('breadcrumbs.edit')
      render :edit
    end
  end

  def destroy
    authorize policy_scope(Diagnosis)
    diagnosis = Diagnosis.includes(components: [:node, :conditions, children: [:node]]).find(params[:id])
    if diagnosis.controlled_destroy
      redirect_to algorithm_version_url(@algorithm, @version), notice: t('flash_message.success_deleted')
    else
      render :new
    end
  end

  # Generate react diagram
  def diagram
    authorize policy_scope(Diagnosis)
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @diagnosis.version.algorithm.name, algorithm_url(@diagnosis.version.algorithm)
    add_breadcrumb t('breadcrumbs.versions')
    add_breadcrumb @diagnosis.version.name, algorithm_version_url(@diagnosis.version.algorithm, @diagnosis.version)
    add_breadcrumb t('breadcrumbs.diagnoses')
  end

  # @params [Diagnosis] diagnosis to duplicate
  # Duplicate a diagnosis with the whole logic (Instances with their Conditions and Children), the FinalDiagnoses and Conditions attached to it
  def duplicate
    authorize policy_scope(Diagnosis)
    diagnosis = Diagnosis.includes(components: [:conditions, :children]).find(params[:id])
    diagnosis.update(duplicating: true)
    duplicated_diagnosis = diagnosis.amoeba_dup

    if duplicated_diagnosis.save
      duplicated_diagnosis.relink_instance
      diagnosis.update(duplicating: false)
      redirect_to algorithm_version_url(@algorithm, @version), notice: t('flash_message.success_duplicated')
    else
      redirect_to algorithm_version_url(@algorithm, @version), alert: t('flash_message.duplicate_fail')
    end
  end

  # @params [Diagnosis]
  # Manually validate a diagnosis and return flash messages to display in the view
  def validate
    @diagnosis.manual_validate
    if @diagnosis.errors.messages.any?
      render json: @diagnosis.errors.messages[:basic], status: 422
    elsif @diagnosis.warnings.messages.any?
      render json: @diagnosis.warnings.messages[:basic], status: 202
    else
      render json: [t('flash_message.diagnosis.valid')], status: 200
    end
  end

  private

  def set_breadcrumb
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
    add_breadcrumb t('breadcrumbs.versions')
    add_breadcrumb @version.name, algorithm_version_url(@algorithm, @version)
    add_breadcrumb t('breadcrumbs.diagnoses'), algorithm_version_url(@algorithm, @version)
  end

  def set_diagnosis
    @diagnosis = Diagnosis.find(params[:id])
    authorize @diagnosis
  end

  def diagnosis_params
    params.require(:diagnosis).permit(
      :id,
      :reference,
      :label_en,
      :node_id,
      :cut_off_start,
      :cut_off_end,
      :cut_off_value_type,
      Language.label_params
    )
  end
end
