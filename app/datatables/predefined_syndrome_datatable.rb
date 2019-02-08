class PredefinedSyndromeDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  # Helpers
  def_delegator :@view, :link_to
  def_delegator :@view, :algorithm_algorithm_version_predefined_syndrome_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  # Column configuration
  def view_columns
    @view_columns ||= {
      reference: { source: 'PredefinedSyndrome.reference' },
      label: { source: 'PredefinedSyndrome.label' },
    }
  end

  # Value display
  def data
    records.map do |record|
      actions = link_to(I18n.t('destroy'), algorithm_algorithm_version_predefined_syndrome_url(params[:algorithm_id], params[:algorithm_version_id], id: record), method: :delete, class: 'btn btn-outline-danger', data: { confirm: 'Are you sure?' })
      {
        reference: record.reference,
        label: record.label,
        actions: actions
      }
    end
  end

  # Activerecord request
  def get_raw_records
    AlgorithmVersion.find(params[:id]).predefined_syndromes
  end
end
