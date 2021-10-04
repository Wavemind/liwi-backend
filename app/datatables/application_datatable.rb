class ApplicationDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def initialize(params, opts = {})
    @view = opts[:view_context]

    if params[:algorithm_id].present?
      @default_language = Algorithm.find(params[:algorithm_id]).study.default_language
    elsif params[:id].present?
      @default_language = Algorithm.find(params[:id]).study.default_language
    end
    super
  end

end
