class ManagementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_management, only: [:edit, :update, :destroy]
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :destroy, :create_exclusion, :remove_exclusion]
  before_action :set_breadcrumb, only: [:new, :edit]

  def new
    add_breadcrumb t('breadcrumbs.new')

    @management = HealthCares::Management.new
    authorize @management
  end

  def edit
    add_breadcrumb @management.label
    add_breadcrumb t('breadcrumbs.edit')
    raise
  end

  def create
    @management = @algorithm.health_cares.managements.new(management_params).becomes(HealthCares::Management)
    authorize @management
    @management.type = HealthCares::Management

    if @management.save
      if params[:from] == 'rails'
        render json: { url: algorithm_url(@algorithm, panel: 'managements'), management: @management }
      else
        diagnostic = Diagnostic.find(params[:diagnostic_id])
        final_diagnostic = FinalDiagnostic.find(params[:final_diagnostic_id])
        final_diagnostic.health_cares << @management
        instance = diagnostic.components.create!(node: @management, final_diagnostic: final_diagnostic)

        render json: instance.generate_json
      end
    else
      render json: @management.errors.full_messages, status: 422
    end
  end

  def update
    if @management.update(management_params)
      if params[:from] == 'rails'
        render json: { url: algorithm_url(@algorithm, panel: 'managements'), management: @management }
      else
        render json: @management.as_json(methods: [:node_type, :type, :category_name])
      end
    else
      render json: @management.errors.full_messages, status: 422
    end
  end

  def destroy
    # If user remove 'disabled' css in button, we verify in controller
    if @management.dependencies?
      redirect_to algorithm_url(@algorithm, panel: 'managements'), alert: t('dependencies')
    else
      if @management.destroy
        redirect_to algorithm_url(@algorithm, panel: 'managements'), notice: t('flash_message.success_updated')
      else
        redirect_to algorithm_url(@algorithm, panel: 'managements'), alert: t('error')
      end
    end
  end

  # POST algorithm/:algorithm_id/managements/create_exclusion
  # @params [Integer] excluding_node_id
  # @params [Integer] excluded_node_id
  # Create an exclusion between two managements
  def create_exclusion
    @management = HealthCares::Management.new
    authorize @management

    @management_exclusion = NodeExclusion.new(management_exclusion_params)
    @management_exclusion.node_type = :management
    if @management_exclusion.save
      redirect_to algorithm_url(@algorithm, panel: 'managements_exclusions'), notice: t('flash_message.success_updated')
    else
      redirect_to algorithm_url(@algorithm, panel: 'managements_exclusions'), alert: @management_exclusion.errors.full_messages
    end
  end

  # DELETE algorithm/:algorithm_id/managements/remove_exclusion
  # @params [Integer] excluding_node_id
  # @params [Integer] excluded_node_id
  # Remove an exclusion between two managements
  def remove_exclusion
    @management = HealthCares::Management.new
    authorize @management

    @management_exclusion = NodeExclusion.management.find_by(management_exclusion_params)
    if @management_exclusion.destroy
      redirect_to algorithm_url(@algorithm, panel: 'managements_exclusions'), notice: t('flash_message.success_updated')
    else
      redirect_to algorithm_url(@algorithm, panel: 'managements_exclusions'), alert: t('error')
    end
  end

  private
  def set_breadcrumb
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'managements')
    add_breadcrumb t('breadcrumbs.managements')
  end

  def set_management
    @management = Node.find(params[:id])
    authorize @management
  end

  def management_params
    management_param = params.require(:health_cares_management).permit(
      :id,
      :reference,
      :type,
      :label_en,
      Language.label_params,
      :description_en,
      Language.description_params,
      :algorithm_id,
      medias_attributes: [
          :id,
          :label_en,
          :url,
          :filename,
          :fileable,
          :_destroy
      ]
    )
    management_param.merge(convert_data_uri_to_upload(management_param))
    management_param
  end

  def management_exclusion_params
    params.require(:node_exclusion).permit(
      :excluding_node_id,
      :excluded_node_id
    )
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
