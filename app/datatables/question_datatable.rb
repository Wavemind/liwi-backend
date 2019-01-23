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
      # actions = link_to(I18n.t('show'), group_url(record), class: 'btn btn-outline-primary') + " " + link_to(I18n.t('edit'), edit_group_url(record), class: 'btn btn-outline-info')
      {
        reference: record.reference,
        label: record.label,
        description: record.description,
        priority: record.priority,
        category: record.category,
        answers: record.answers.first.name,
        answer_type: record.answer_type.display,
      }
    end
  end

  # Activerecord request
  def get_raw_records
    Algorithm.find(params[:id]).questions
  end

end
