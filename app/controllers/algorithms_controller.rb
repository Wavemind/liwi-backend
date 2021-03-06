class AlgorithmsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:show, :edit, :update, :archive, :unarchive, :questions, :generate_villages, :import_villages, :managements, :questions, :questions_sequences, :questions_sequences_scored, :drugs, :drug_exclusions, :management_exclusions, :villages]

  def index
    authorize policy_scope(Algorithm)
    add_breadcrumb t('breadcrumbs.algorithms')

    respond_to do |format|
      format.html
      format.json { render json: AlgorithmDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name
  end

  def new
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb t('breadcrumbs.new')
    @algorithm = Algorithm.new
    authorize @algorithm
  end

  def edit
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
    add_breadcrumb t('breadcrumbs.edit')

  end

  def create
    @algorithm = Algorithm.new(algorithm_params)
    @algorithm.user = current_user
    authorize @algorithm
    if @algorithm.save
      redirect_to algorithms_url, notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @algorithm.update(algorithm_params)
      redirect_to algorithms_url, notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  # PUT algorithms/:id/archive
  # @params algorithm [Algorithm] algorithm to archive
  # @return redirect to algorithms#index with flash message
  # Archive the given algorithm. There is no impact for the user but if a parent is archived, the versions are considered archived too
  def archive
    @algorithm.archived = true

    if @algorithm.save
      flash[:notice] = t('flash_message.success_archive')
      render json: { status: 'success' }
    else
      flash[:alert] = t('flash_message.update_fail')
      render json: { status: 'failed' }
    end
  end

  # GET algorithms/:id/drug
  # @params algorithm [Algorithm] algorithm
  # @return json of drugs
  # All drugs available for the given algorithm
  def drugs
    respond_to do |format|
      format.js { }
      format.json { render json: DrugDatatable.new(params, view_context: view_context) }
    end
  end

  # GET algorithms/:id/drug_exclusion
  # @params algorithm [Algorithm] algorithm
  # @return json of drug_exclusions
  # All exclusions on the drugs of the given algorithm
  def drug_exclusions
    respond_to do |format|
      format.js { }
      format.json { render json: DrugExclusionDatatable.new(params, view_context: view_context) }
    end
  end

  # PUT algorithms/:algorithm_id/import_villages
  # @params algorithm [Algorithm] algorithm
  # @params file [File] xl file with the villages in columns
  # Import an excel file to input the villages
  def import_villages
    file = params[:algorithm][:file]
    if file.present? && File.extname(file.original_filename).include?('xls')
      xl_file = Roo::Spreadsheet.open(file.path, extension: :xlsx)
      xl_file.default_sheet = xl_file.sheets.first
      test_array = []
      villages = []
      2.upto(xl_file.last_row).each do |line|
        full_string = xl_file.row(line).reverse.join(', ')
        unless test_array.include?(full_string)
          current_village = {}
          test_array << full_string
          current_village[xl_file.row(line).last] = full_string
          villages << current_village
        end
      end
      if @algorithm.update!(village_json: villages)
        redirect_to algorithm_url(@algorithm, panel: 'villages'), notice: t('flash_message.import_successful_villages')
      else
        redirect_to algorithm_url(@algorithm, panel: 'villages'), alert: t('flash_message.import_xl_error_villages')
      end
    else
      redirect_to algorithm_url(@algorithm, panel: 'villages'), alert: t('flash_message.import_xl_wrong_file_villages')
    end
  end

  # GET algorithms/:id/management
  # @params algorithm [Algorithm] algorithm
  # @return json of managements
  # All managements available for given algorithm
  def managements
    respond_to do |format|
      format.js { }
      format.json { render json: ManagementDatatable.new(params, view_context: view_context) }
    end
  end

  # GET algorithms/:id/management_exclusion
  # @params algorithm [Algorithm] algorithm
  # @return json of management_exclusions
  # All exclusions on the managements of the given algorithm
  def management_exclusions
    respond_to do |format|
      format.js { }
      format.json { render json: ManagementExclusionDatatable.new(params, view_context: view_context) }
    end
  end

  # GET algorithms/:id/question
  # @params algorithm [Algorithm] algorithm
  # @return json of questions
  # All questions available for given algorithm
  def questions
    respond_to do |format|
      format.js { }
      format.json { render json: QuestionDatatable.new(params, view_context: view_context) }
    end
  end

  # GET algorithms/:id/questions_sequence
  # @params algorithm [Algorithm] algorithm
  # @return json of questions_sequences
  # All questions sequences available for given algorithm
  def questions_sequences
    respond_to do |format|
      format.js { }
      format.json { render json: QuestionsSequenceDatatable.new(params, view_context: view_context) }
    end
  end

  # GET algorithms/:id/questions_sequence_scored
  # @params algorithm [Algorithm] algorithm
  # @return json of questions_sequences_scored
  # All questions sequences scored available for given algorithm
  def questions_sequences_scored
    respond_to do |format|
      format.js { }
      format.json { render json: QuestionsSequenceScoredDatatable.new(params, view_context: view_context) }
    end
  end

  # PUT algorithms/:id/unarchive
  # @params algorithm [Algorithm] algorithm to unarchive
  # @return redirect to algorithms#index with flash message
  # Unarchive the given algorithm.
  def unarchive
    @algorithm.archived = false

    if @algorithm.save
      redirect_to algorithms_url, notice: t('flash_message.success_created')
    else
      redirect_to algorithms_url, danger: t('flash_message.update_fail')
    end
  end

  # GET algorithms/:id/questions_sequence_scored
  # @params algorithm [Algorithm] algorithm
  # Display villages view
  def villages
    respond_to do |format|
      format.js { }
    end
  end

  private

  def set_algorithm
    @algorithm = Algorithm.find(params[:id])
    authorize @algorithm
  end

  def algorithm_params
    params.require(:algorithm).permit(
      :id,
      :name,
      :description,
      :consent_management,
      :track_referral,
      :study_id,
      Language.language_params('emergency_content'),
    )
  end
end
