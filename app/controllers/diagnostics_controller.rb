class DiagnosticsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:show, :new, :create, :edit, :update, :destroy, :duplicate]
  before_action :set_version, only: [:show, :new, :create, :edit, :update, :destroy, :duplicate]
  before_action :set_diagnostic, only: [:show, :edit, :update, :create_link, :diagram, :update_translations]
  before_action :set_child, only: [:create_link, :remove_link]
  before_action :set_parent, only: [:create_link, :remove_link]
  layout 'diagram', only: [:diagram]

  def index
    respond_to do |format|
      format.html
      format.json { render json: DiagnosticDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
    add_breadcrumb @version.name, algorithm_version_url(@algorithm, @version)
    add_breadcrumb @diagnostic.label

    @instance = Instance.new
    @instanceable = @diagnostic
    @conditions = @diagnostic.conditions
    @condition = Condition.new
  end

  def new
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
    add_breadcrumb @version.name, algorithm_version_url(@algorithm, @version)

    @diagnostic = Diagnostic.new
  end

  def edit
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
    add_breadcrumb @version.name, algorithm_version_url(@algorithm, @version)
    add_breadcrumb @diagnostic.reference, algorithm_version_diagnostic_url(@algorithm, @version)
  end

  def create
    @diagnostic = @version.diagnostics.new(diagnostic_params)

    if @diagnostic.save
      redirect_to algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic), notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @diagnostic.update(diagnostic_params)
      redirect_to algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic), notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  def destroy
    diagnostic = Diagnostic.includes(components: [:node, :conditions, children: [:node]]).find(params[:id])
    if diagnostic.destroy
      redirect_to algorithm_version_url(@algorithm, @version), notice: t('flash_message.success_deleted')
    else
      render :new
    end
  end

  # @params [Diagnostic] Current diagnostic, [Answer] Answer from parent of the link, [Node] child of the link
  # Create link in both way from diagram
  def create_link
    @parent_instance.children.new(node: @child_node)
    @child_instance.conditions.new(first_conditionable: @parent_answer, top_level: true)

    if @parent_instance.save && @child_instance.save
      render json: { status: 'success', message: t('flash_message.success_created')}
    else
      render json: { status: 'alert', message: t('flash_message.update_fail')}
    end
  end

  # Generate react diagram
  def diagram
  end

  # @params [Diagnostic] diagnostic to duplicate
  # Duplicate a diagnostic with the whole logic (Instances with their Conditions and Children), the FinalDiagnostics and Conditions attached to it
  def duplicate
    diagnostic = Diagnostic.includes(components: [:conditions, :children]).find(params[:id])
    duplicated_diagnostic = diagnostic.amoeba_dup
    if duplicated_diagnostic.save
      duplicated_diagnostic.relink_instance
      redirect_to algorithm_version_url(@algorithm, @version), notice: t('flash_message.success_deleted')
    else
      render :new
    end
  end

  # @params [Diagnostic] Current diagnostic, [Answer] Answer from parent of the link, [Node] child of the link
  # Remove a link from diagram and remove from both child and parent concerned
  def remove_link
    @child_instance.conditions.each do |cond|
      Instance.remove_condition(cond, @parent_instance)
    end

    if @parent_instance.children.find_by(node: @chlid_node).destroy
      render json: { status: 'success', message: t('flash_message.success_deleted')}
    else
      render json: { status: 'alert', message: t('flash_message.delete_fail')}
    end
  end

  # @params Diagnostic with the translations
  # Update the object with its translation without
  def update_translations
    if @diagnostic.update(diagnostic_params)
      @json = { status: 'success', message: t('flash_message.success_updated') }
      render 'update_translations', formats: :js, status: :ok
    else
      @json = { status: 'alert', message: t('flash_message.update_fail') }
      render 'update_translations', formats: :js, status: :unprocessable_entity
    end
  end

  private

  def set_child
    @child_node = Node.find(diagnostic_params[:node_id])
    @child_instance = @diagnostic.components.find_by(node_id: child_node.id)
  end

  def set_parent
    @parent_answer = Answer.find(diagnostic_params[:answer_id])
    @parent_instance = @diagnostic.components.find_by(node_id: parent_answer.node_id)
  end

  def set_diagnostic
    @diagnostic = Diagnostic.find(params[:id])
  end

  def diagnostic_params
    params.require(:diagnostic).permit(
      :id,
      :reference,
      :label_en,
      Language.label_params,
      :answer_id,
      :node_id
    )
  end
end
