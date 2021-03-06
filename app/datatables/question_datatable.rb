# Configuration for question datatable display
class QuestionDatatable < ApplicationDatatable
  extend Forwardable

  # Helpers
  def_delegator :@view, :link_to
  def_delegator :@view, :edit_algorithm_question_url
  def_delegator :@view, :algorithm_question_url

  # Column configuration
  def view_columns
    @view_columns ||= {
      id: { source: 'Question.id' },
      category: { source: 'Question.type' },
      reference: { source: 'Question.reference' },
      label: { source: 'Question.label_translations' },
      description: { source: 'Question.description_translations' },
      is_mandatory: { source: 'Question.is_mandatory' },
    }
  end

  # Value display
  def data
    records.map do |record|
      actions = link_to(I18n.t('edit'), edit_algorithm_question_url(params[:id], record), class: "btn btn-outline-success") + " " + link_to(I18n.t('delete'), algorithm_question_url(record.algorithm, record), class: "btn btn-outline-danger #{(record.dependencies? || record.used_in_deployed_version || record.is_default) ? 'disabled' : ''}", method: :delete, data: { confirm: I18n.t('confirmation') })
      {
        id: record.id,
        reference: record.full_reference,
        label: record.send("label_#{@default_language}"),
        description: record.send("description_#{@default_language}"),
        is_mandatory: record.is_mandatory,
        category: Object.const_get(record.type).display_label,
        answers: record.answers.map{|an| an.send("label_#{@default_language}")}.join(' / '),
        answer_type: record.answer_type.display_name,
        actions: actions,
        is_neonat: record.is_neonat, # is a hidden column in the datatable in question.js
      }
    end
  end

  # Activerecord request
  def get_raw_records
    Algorithm.find(params[:id]).questions.includes([:instances, :answers, :answer_type, :algorithm])
  end

end
