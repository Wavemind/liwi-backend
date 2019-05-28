class PredefinedSyndromeScoredDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  # Helpers
  def_delegator :@view, :link_to
  def_delegator :@view, :diagram_predefined_syndrome_url
  def_delegator :@view, :edit_scored_algorithm_predefined_syndrome_url
  def_delegator :@view, :algorithm_predefined_syndrome_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  # Column configuration
  def view_columns
    @view_columns ||= {
      reference: { source: 'PredefinedSyndrome.reference' },
      label: { source: 'PredefinedSyndrome.label_translations' },
      min_score: { soruce: 'PredefinedSyndrome.min_score' },
      description: { source: 'PredefinedSyndrome.description_translations' },
    }
  end

  # Value display
  def data
    records.map do |record|
      actions = link_to(I18n.t('show'), diagram_predefined_syndrome_url(record), class: 'btn btn-outline-primary') + " " + link_to(I18n.t('edit'), edit_scored_algorithm_predefined_syndrome_url(params[:id], record), class: 'btn btn-outline-info') + " " + link_to(I18n.t('delete'), algorithm_predefined_syndrome_url(record.algorithm, record), class: "btn btn-outline-danger #{record.dependencies? ? 'disabled' : ''}", method: :delete, data: { confirm: 'Are you sure?' })
      {
        reference: record.reference,
        category: record.category.name,
        label: record.label,
        min_score: record.min_score,
        description: record.description,
        actions: actions
      }
    end
  end

  # Activerecord request
  def get_raw_records
    Algorithm.find(params[:id]).predefined_syndromes.scored.includes(:instances, :category, :algorithm)
  end
end
