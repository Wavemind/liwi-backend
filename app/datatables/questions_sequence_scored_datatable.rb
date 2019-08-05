class QuestionsSequenceScoredDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  # Helpers
  def_delegator :@view, :link_to
  def_delegator :@view, :diagram_questions_sequence_url
  def_delegator :@view, :edit_scored_algorithm_questions_sequence_url
  def_delegator :@view, :algorithm_questions_sequence_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  # Column configuration
  def view_columns
    @view_columns ||= {
      reference: { source: 'QuestionsSequence.reference' },
      label: { source: 'QuestionsSequence.label_translations' },
      min_score: { source: 'QuestionsSequence.min_score' },
      description: { source: 'QuestionsSequence.description_translations' },
    }
  end

  # Value display
  def data
    records.map do |record|
      actions = link_to(I18n.t('show'), diagram_questions_sequence_url(record), class: 'btn btn-outline-primary') + " " + link_to(I18n.t('edit'), edit_scored_algorithm_questions_sequence_url(params[:id], record), class: 'btn btn-outline-info') + " " + link_to(I18n.t('delete'), algorithm_questions_sequence_url(record.algorithm, record), class: "btn btn-outline-danger #{record.dependencies? ? 'disabled' : ''}", method: :delete, data: { confirm: 'Are you sure?' })
      {
        reference: record.reference,
        label: record.label,
        min_score: record.min_score,
        description: record.description,
        actions: actions
      }
    end
  end

  # Activerecord request
  def get_raw_records
    Algorithm.find(params[:id]).questions_sequences.scored.includes(:algorithm)
  end
end
