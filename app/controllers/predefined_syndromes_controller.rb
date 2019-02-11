class PredefinedSyndromesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_predefined_syndrome, only: [:destroy, :show]

  def show
    @relation = Relation.new
    @relationable = @predefined_syndrome
  end

  def destroy
    if @predefined_syndrome.destroy
      redirect_to @algorithm, notice: t('flash_message.success_updated')
    else
      redirect_to @algorithm, alert: t('error')
    end
  end

  private

  def set_predefined_syndrome
    @predefined_syndrome = PredefinedSyndrome.find(params[:id])
  end

end
