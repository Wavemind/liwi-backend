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
    @group_id = health_facility.id.to_s
    @study_id = study_id.to_s
    @uuid = SecureRandom.uuid
    @number_of_stickers = number_of_stickers.to_i

    qr_content = {study_id: @study_id, group_id: @group_id, uid: @uuid}.to_json

    (1..@number_of_stickers).each do |sticker|
      define_grid(columns: 5, rows: 1, gutter: 0)
        grid([0, 0], [0, 1]).bounding_box do
        move_down 0.4.cm
        qrcode = RQRCode::QRCode.new(qr_content, level: :h)
        render_qr_code(qrcode, align: :left, extent: 2.1.cm)
      end
      grid([0, 2], [0, 4]).bounding_box do
        font_size 8
        indent(0.05.cm) do
          move_down 0.4.cm
          text "study_id: #{@study_id}"
          move_down 0.4.cm
          text "group_id: #{@group_id}"
          move_down 0.4.cm
          text "uid: #{@uuid}"
        end
      end
      start_new_page unless sticker == @number_of_stickers
    end
  end
end
