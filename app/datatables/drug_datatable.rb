class DrugDatatable < ApplicationDatatable
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :edit_algorithm_drug_url
  def_delegator :@view, :algorithm_drug_url

  def view_columns
    @view_columns ||= {
      id: { source: 'HealthCares::Drug.id' },
      reference: { source: 'HealthCares::Drug.reference' },
      label: { source: 'HealthCares::Drug.label_translations' },
      description: { source: 'HealthCares::Drug.description_translations' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('edit'), edit_algorithm_drug_url(params[:id], record), class: 'btn btn-outline-success') + " " + link_to(I18n.t('delete'), algorithm_drug_url(record.algorithm, record), class: "btn btn-outline-danger #{record.dependencies? ? 'disabled' : ''}", method: :delete, data: { confirm: I18n.t('confirmation') })
      {
        id: record.id,
        reference: record.full_reference,
        label: record.send("label_#{@default_language}"),
        description: record.send("description_#{@default_language}"),
        actions: actions,
        is_neonat: record.is_neonat, # is a hidden column in the datatable in question.js
      }
    end
  end

  def get_raw_records
    Algorithm.find(params[:id]).health_cares.drugs.includes([:algorithm])
  end
end
