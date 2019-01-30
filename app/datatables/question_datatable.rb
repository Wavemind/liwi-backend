# Configuration for question datatable display
class QuestionDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  # Helpers
  def_delegator :@view, :link_to
  def_delegator :@view, :edit_algorithm_question_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  # Column configuration
  def view_columns
    @view_columns ||= {
      reference: { source: 'Question.reference' },
      label: { source: 'Question.label' },
      description: { source: 'Question.description' },
      priority: { source: 'Question.priority' },
      category: { source: 'Question.category' },
    }
  end

  # Value display
  def data
    records.map do |record|
      actions = link_to(I18n.t('edit'), edit_algorithm_question_url(params[:id], record), class: 'btn btn-outline-info')
      {
        reference: record.reference,
        label: record.label,
        description: record.description,
        priority: I18n.t("questions.priorities.#{record.priority}"),
        category: record.category.name,
        answers: record.answers.map(&:label).join(' / '),
        answer_type: record.answer_type.display_name,
        actions: actions
      }
    end
  end

  # Activerecord request
  def get_raw_records
    Algorithm.find(params[:id]).questions.includes([:answers, :answer_type, :category])
  end

end
