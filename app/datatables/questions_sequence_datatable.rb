class QuestionsSequenceDatatable < ApplicationDatatable
  extend Forwardable

  # Helpers
  def_delegator :@view, :link_to
  def_delegator :@view, :diagram_questions_sequence_url
  def_delegator :@view, :edit_algorithm_questions_sequence_url
  def_delegator :@view, :algorithm_questions_sequence_url

  # Column configuration
  def view_columns
    @view_columns ||= {
      id: { source: 'QuestionsSequence.id' },
      reference: { source: 'QuestionsSequence.reference' },
      label: { source: 'QuestionsSequence.label_translations' },
      description: { source: 'QuestionsSequence.description_translations' },
      category: { source: 'QuestionsSequence.type' },
    }
  end

  # Value display
  def data
    records.map do |record|
      actions = link_to(I18n.t('show'), diagram_questions_sequence_url(record), class: 'btn btn-outline-info') + " " + link_to(I18n.t('edit'), edit_algorithm_questions_sequence_url(record.algorithm, record), class: 'btn btn-outline-success') + " " + link_to(I18n.t('delete'), algorithm_questions_sequence_url(record.algorithm, record), class: "btn btn-outline-danger #{record.dependencies? ? 'disabled' : ''}", method: :delete, data: { confirm: I18n.t('confirmation') })
      {
        id: record.id,
        reference: record.full_reference,
        label: record.send("label_#{@default_language}"),
        description: record.send("description_#{@default_language}"),
        category: Object.const_get(record.type).display_label,
        actions: actions
      }
    end
  end

  # Activerecord request
  def get_raw_records
    Algorithm.find(params[:id]).questions_sequences.not_scored.includes(:algorithm)
  end
end
