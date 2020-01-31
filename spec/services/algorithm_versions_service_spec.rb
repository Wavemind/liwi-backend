require 'rails_helper'

RSpec.describe VersionsService, type: :service do
  create_full_algorithm_version

  it 'generates a json with correct amount of questions and answers' do
    answers_count = 0
    nodes = @json['nodes']
    nodes.each do |key, node|
      answers_count += node['answers'].count if node['answers'].present?
    end
    expect(nodes.count).to eq(20)
    expect(answers_count).to eq(25)
  end

  it 'generates a json with correct amount of conditions' do
    json = JSON.parse(@json.to_json)
    top_conditions = json['diagnostics'].values[0]['final_diagnostics'].values[0]['top_conditions']
    conditions = json['diagnostics'].values[0]['final_diagnostics'].values[0]['conditions']

    expect(top_conditions.count + conditions.count).to eq(3)
    expect(top_conditions[1]['first_id']).to eq(25)
    expect(top_conditions[1]['second_id']).to eq(26)
  end
end
