# Configuration for question datatable display
class QuestionDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  # Helpers
  def_delegator :@view, :link_to
  def_delegator :@view, :edit_algorithm_question_url
  def_delegator :@view, :algorithm_question_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  # Column configuration
  def view_columns
    @view_columns ||= {
      category: { source: 'Question.type' },
      reference: { source: 'Question.reference' },
      label: { source: 'Question.label_translations' },
      description: { source: 'Question.description_translations' },
      priority: { source: 'Question.priority' },
    }
  end

  # Value display
  def data
    records.map do |record|
      actions = link_to(I18n.t('edit'), edit_algorithm_question_url(params[:id], record), class: 'btn btn-outline-info') + " " + link_to(I18n.t('delete'), algorithm_question_url(record.algorithm, record), class: "btn btn-outline-danger #{record.instance_dependencies? ? 'disabled' : ''}", method: :delete, data: { confirm: 'Are you sure?' })
      {
        reference: record.full_reference,
        label: record.label,
        description: record.description,
        priority: I18n.t("questions.priorities.#{record.priority}"),
        category: Object.const_get(record.type).display_label,
        answers: record.answers.map(&:label).join(' / '),
        answer_type: record.answer_type.display_name,
        actions: actions
      }
    end
  end

  # Activerecord request
  def get_raw_records
    Algorithm.find(params[:id]).questions.includes([:answers, :answer_type, :algorithm])
  end

end
