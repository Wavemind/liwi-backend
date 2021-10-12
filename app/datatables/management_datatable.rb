class ManagementDatatable < ApplicationDatatable
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :edit_algorithm_management_url
  def_delegator :@view, :algorithm_management_url

  def view_columns
    @view_columns ||= {
      id: { source: 'HealthCares::Management.id' },
      reference: { source: 'HealthCares::Management.reference' },
      label: { source: 'HealthCares::Management.label_translations' },
      description: { source: 'HealthCares::Management.description_translations' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('edit'), edit_algorithm_management_url(params[:id], record), class: 'btn btn-outline-success') + " " + link_to(I18n.t('delete'), algorithm_management_url(record.algorithm, record), class: "btn btn-outline-danger #{record.dependencies? ? 'disabled' : ''}", method: :delete, data: { confirm: I18n.t('confirmation') })
      {
        id: record.id,
        reference: record.full_reference,
        label: record.send("label_#{@default_language}"),
        description: record.send("description_#{@default_language}"),
        actions: actions
      }
    end
  end

  def get_raw_records
    Algorithm.find(params[:id]).health_cares.managements.includes([:algorithm])
  end
end
