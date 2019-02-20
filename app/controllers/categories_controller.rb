class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :reference]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_url, notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_url, notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  # @param [Category]
  # @return [String] with the prefix
  # Method to get the prefix to the given category for the view
  def reference
    render json: @category.reference_prefix
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(
      :name_en,
    )
  end
end
