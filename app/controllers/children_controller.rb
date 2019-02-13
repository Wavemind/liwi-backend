class ChildrenController < ApplicationController
  before_action :authenticate_user!
  before_action :set_relationable, only: [:index, :show, :create, :destroy]
  before_action :set_relation, only: [:show, :create, :destroy]
  before_action :set_child, only: [:destroy]

  def create
    @child = @relation.children.new(child_params)

    if @child.save
      redirect_to polymorphic_url([@relationable, @relation]), notice: t('flash_message.success_created')
    else
      redirect_to polymorphic_url([@relationable, @relation]), alert: t('error')
    end
  end

  def destroy
    if @child.destroy
      redirect_to polymorphic_url([@relationable, @relation]), notice: t('flash_message.success_updated')
    else
      redirect_to polymorphic_url([@relationable, @relation]), alert: t('error')
    end
  end

  private

  def set_child
    @child = Child.find(params[:id])
  end

  def set_relation
    @relation = Relation.find(params[:relation_id])
  end

  def set_relationable
    if params[:diagnostic_id].present?
      @relationable = Diagnostic.find(params[:diagnostic_id])
    elsif params[:predefined_syndrome_id].present?
      @relationable = PredefinedSyndrome.find(params[:predefined_syndrome_id])
    else
      raise t('.errors.unknown_relationable')
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
