class ChildrenController < ApplicationController
  before_action :authenticate_user!
  before_action :set_instanceable, only: [:index, :show, :create, :destroy]
  before_action :set_instance, only: [:show, :create, :destroy]
  before_action :set_child, only: [:destroy]

  def create
    @child = @instance.children.new(child_params)

    if @child.save
      redirect_to polymorphic_url([@instanceable, @instance]), notice: t('flash_message.success_created')
    else
      redirect_to polymorphic_url([@instanceable, @instance]), alert: t('error')
    end
  end

  def destroy
    if @child.destroy
      redirect_to polymorphic_url([@instanceable, @instance]), notice: t('flash_message.success_updated')
    else
      redirect_to polymorphic_url([@instanceable, @instance]), alert: t('error')
    end
  end

  private

  def set_child
    @child = Child.find(params[:id])
  end

  def set_instanceable
    if params[:diagnostic_id].present?
      @instanceable = Diagnostic.find(params[:diagnostic_id])
    elsif params[:questions_sequence_id].present?
      @instanceable = QuestionsSequence.find(params[:questions_sequence_id])
    else
      raise t('.errors.unknown_instanceable')
    end
  end

  def child_params
    params.require(:child).permit(
      :id,
      :weight,
      :node_id,
    )
  end
end
