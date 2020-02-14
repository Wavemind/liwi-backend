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
      id: { source: 'HealthCares::Treatment.id' },
      reference: { source: 'HealthCares::Treatment.reference' },
      label: { source: 'HealthCares::Treatment.label_translations' },
      description: { source: 'HealthCares::Treatment.description_translations' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('edit'), edit_algorithm_treatment_url(params[:id], record), class: 'btn btn-outline-info') + " " + link_to(I18n.t('delete'), algorithm_treatment_url(record.algorithm, record), class: "btn btn-outline-danger #{record.dependencies? ? 'disabled' : ''}", method: :delete, data: { confirm: 'Are you sure?' })
      {
        id: record.id,
        reference: record.full_reference,
        label: record.label,
        description: record.description,
        actions: actions
      }
    end
  end

  def get_raw_records
    Algorithm.find(params[:id]).health_cares.treatments.includes([:algorithm])
  end
end
