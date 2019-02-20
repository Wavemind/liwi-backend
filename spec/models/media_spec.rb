require 'rails_helper'

RSpec.describe Media, type: :model do
  create_algorithm
  create_question

  it 'is valid with valid attributes' do
    media = Media.new(label: 'TestUnits', url: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/leprosy.gif'))), fileable: @question)
    expect(media).to be_valid
  end

  it 'is invalid with invalid attributes' do
    media = Media.new(label: 'TestUnits', url: nil, fileable: @question)
    expect(media).to_not be_valid
  end
end
