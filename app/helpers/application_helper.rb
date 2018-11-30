module ApplicationHelper

  def flash_class(level)
    case level
    when 'notice' then
      'alert alert-success'
    when 'success' then
      'alert alert-success'
    when 'error' then
      'alert alert-danger'
    when 'alert' then
      'alert alert-danger'
    end
  end

  def date_format(date)
    if date.blank?
      '<em>Non défini</em>'.html_safe
    else
      date.strftime('%d.%m.%Y')
    end
  end

  def datetime_format(date)
    if date.blank?
      '<em>Non défini</em>'.html_safe
    else
      date.strftime('%d.%m.%Y at %H:%M')
    end
  end

  def time_format(date)
    if date.blank?
      '<em>Non défini</em>'.html_safe
    else
      date.strftime('%Hh')
    end
  end

end
