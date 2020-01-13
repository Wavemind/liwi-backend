# Version of an algorithm with its logic
class Version < ApplicationRecord

  attr_accessor :triage_id
  attr_accessor :cc_id

  belongs_to :algorithm
  belongs_to :user

  has_many :diagnostics, dependent: :destroy
  has_many :medical_case_answers

  has_many :group_accesses
  has_many :groups, through: :group_accesses

  has_many :components, class_name: 'Instance', as: :instanceable, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :algorithm

  after_create :instantiate_questions

  # @return [String]
  # Return a displayable string for this version
  def display_label
    "#{algorithm.name} - #{name}"
  end

  # Create an instance per question who has triage stage or basic measurement category
  def instantiate_questions
    algorithm.questions.triage.each do |question|
      components.create!(node: question)
      self.update("#{question.version_field_to_set}": self.send("#{question.version_field_to_set}").push(question.id))
    end
  end
end
