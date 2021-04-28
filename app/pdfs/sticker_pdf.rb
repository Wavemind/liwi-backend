require 'prawn'
require 'prawn/measurement_extensions'
require 'prawn/qrcode'
require 'securerandom'
require 'json'

class StickerPdf < Prawn::Document
  def initialize(health_facility, study_id, number_of_stickers)
    super(
      page_size: [2.9.cm, 6.2.cm],
      page_layout: :landscape,
      margin: [0, 0.42.cm, 0, 0.2.cm],
    )
    group_id = health_facility.id.to_s
    study_id = study_id.label
    number_of_stickers = number_of_stickers.to_i

    (1..number_of_stickers).each do |sticker|
      uuid = SecureRandom.uuid

      qr_content = {study_id: study_id, group_id: group_id, uid: uuid}.to_json
      define_grid(columns: 6, rows: 1, gutter: 0)
      grid([0, 0], [0, 2]).bounding_box do
        move_down 0.2.cm
        qrcode = RQRCode::QRCode.new(qr_content, level: :h)
        render_qr_code(qrcode, align: :left, extent: 2.6.cm)
      end
      grid([0, 3], [0, 5]).bounding_box do
        font_size 7
        indent(0.1.cm) do
          move_down 0.2.cm
          text "<b>study_id:</b> #{study_id}", inline_format: true
          move_down 0.3.cm
          text "<b>group_id:</b> #{group_id}", inline_format: true
          move_down 0.3.cm
          text "<b>uid:</b> #{uuid}", inline_format: true
        end
      end
      start_new_page unless sticker == number_of_stickers
    end
  end
end
