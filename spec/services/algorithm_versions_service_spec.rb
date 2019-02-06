require 'rails_helper'

RSpec.describe AlgorithmVersionsService, type: :service do
  create_full_algorithm_version

  it 'generates a json with correct amount of questions and answers' do
    answers_count = 0
    questions = @json['questions']
    questions.each do |key, question|
      answers_count += question['answers'].count
    end
    expect(questions.count).to eq(5)
    expect(answers_count).to eq(10)
  end

  it 'generates a json with correct amount of predefined syndromes and answers' do
    answers_count = 0
    predefined_syndromes = @json['predefined_syndromes']
    predefined_syndromes.each do |key, predefined_syndrome|
      answers_count += predefined_syndrome['answers'].count
    end
    expect(predefined_syndromes.count).to eq(1)
    expect(answers_count).to eq(2)
  end

  it 'generates a json with correct amount of managements' do
    expect(@json['managements'].count).to eq(1)
  end

  it 'generates a json with correct amount of treatments' do
    expect(@json['treatments'].count).to eq(3)
  end

  it 'generates a json with correct amount of conditions', focus: :true do
    json = JSON.parse(@json.to_json)
    top_conditions = json["diseases"][0]["1"]["nodes"].last["diagnosis"]["1"]["top_conditions"]
    conditions = json["diseases"][0]["1"]["nodes"].last["diagnosis"]["1"]["conditions"]

    expect(top_conditions.count + conditions.count).to eq(3)
    expect(top_conditions[1]["9"]["first_id"]).to eq(8)
    expect(top_conditions[1]["9"]["second_id"]).to eq(9)
  end

end
