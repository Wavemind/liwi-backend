require 'prawn'
require 'prawn/measurement_extensions'
require 'prawn/qrcode'

class StickerPdf < Prawn::Document
  def initialize(health_facility, study_id, number_of_stickers)
    super(
      page_size: [2.9.cm, 6.2.cm],
      page_layout: :landscape,
      margin: [0, 0.42.cm, 0, 0.2.cm],
    )
    @group_id = health_facility.id.to_s
    @study_id = study_id.to_s
    @number_of_stickers = number_of_stickers.to_i

    qr_content = @group_id

    (1..@number_of_stickers).each do |sticker|
      define_grid(columns: 2, rows: 1, gutter: 0)
      grid(0, 0).bounding_box do
        move_down 0.4.cm
        qrcode = RQRCode::QRCode.new(qr_content, level: :h)
        render_qr_code(qrcode, align: :left, extent: 2.1.cm)
      end
      grid(0, 1).bounding_box do
        move_down 0.4.cm
        font_size 8
        text "study_id: #{@study_id}"
        text "group_id: #{@group_id}"
        # text 'uid: ' + @study_id
      end
      start_new_page unless sticker == @number_of_stickers
    end
  end
end
