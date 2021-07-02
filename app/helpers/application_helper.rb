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

  # QRCode generator
  def generate_qr(text)
    require 'barby'
    require 'barby/barcode'
    require 'barby/barcode/qr_code'
    require 'barby/outputter/png_outputter'

    barcode = Barby::QrCode.new(text, level: :q, size: 18)
    base64_output = Base64.encode64(barcode.to_png({ xdim: 3 }))
    "data:image/png;base64,#{base64_output}"
  end

end
