# Configuration for question datatable display
class QuestionDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  # Helpers

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
      {
        reference: record.reference,
        label: record.label,
        description: record.description,
        priority: I18n.t("questions.priorities.#{record.priority}"),
        category: I18n.t("questions.categories.#{record.category}"),
        answers: record.answers.map(&:label).join(' / '),
        answer_type: record.answer_type.display_name,
      }
    end
  end

  # Activerecord request
  def get_raw_records
    Algorithm.find(params[:id]).questions
  end

end
