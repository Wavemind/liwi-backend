class TreatmentDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :edit_algorithm_treatment_url
  def_delegator :@view, :algorithm_treatment_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      id: { source: 'Treatment.id' },
      name: { source: 'Treatment.reference' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('edit'), edit_algorithm_treatment_url(params[:id], record), class: 'btn btn-outline-info')
      {
        id: record.id,
        reference: record.reference,
        label: record.label,
        description: record.description,
        actions: actions
      }
    end
  end

  def get_raw_records
    Algorithm.find(params[:id]).treatments
  end
end
