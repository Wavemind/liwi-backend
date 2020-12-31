class StickerPdf < Prawn::Document
  def initialize(health_facility, study_id, number_of_stickers)
    super()
    @health_facility = health_facility
    @study_id = study_id
    @number_of_stickers = number_of_stickers
    stroke_axis
    box
  end

  def box
    bounding_box([100, 300], width: 300, height: 200) do
      stroke_bounds
    end
  end
end
