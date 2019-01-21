module ApplicationHelper

  # Flash message css
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

  # Date format: dd.mm.yyyy
  def date_format(date)
    if date.blank?
      '<em>Not set</em>'.html_safe
    else
      date.strftime('%d.%m.%Y')
    end
  end

  # Date with time format: dd.mm.yyyy at HH:MM
  def datetime_format(date)
    if date.blank?
      '<em>Not set</em>'.html_safe
    else
      date.strftime('%d.%m.%Y at %H:%M')
    end
  end

  # Time format: HH:MM
  def time_format(date)
    if date.blank?
      '<em>Not set</em>'.html_safe
    else
      date.strftime('%Hh')
    end
  end

end
