# Every component of an algorithm
class Node < ApplicationRecord

  # DF are not linked to algorithm this way, but through diagnostic > version
  belongs_to :algorithm, optional: true
  has_many :children
  has_many :instances
  has_many :medias, as: :fileable

  has_many :final_diagnostic_health_cares
  has_many :final_diagnostics, through: :final_diagnostic_health_cares

  has_many :medical_case_health_cares
  has_many :medical_cases, through: :medical_case_health_cares

  scope :managements, ->() { where(type: 'Management') }
  scope :treatments, ->() { where(type: 'Treatment') }

  accepts_nested_attributes_for :medias, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :label
  validates_presence_of :reference

  after_validation :unique_reference
  before_create :complete_reference

  translates :label, :description

  # @return [String]
  # Return the label with the reference for the view
  def reference_label
    "#{reference} - #{label}"
  end

  # @return [Boolean]
  # Verify if current node have instances dependencies
  def dependencies?
    instances.where.not(instanceable: self).any?
  end

  # @return [ActiveRecord::Association]
  # List of instances
  def dependencies
    instances
  end

  # Automatically create the answers, since they can't be changed
  # Create 2 automatic answers (yes & no) for PS and boolean questions
  def create_boolean
    self.answers << Answer.new(reference: '1', label_en: I18n.t('answers.yes'))
    self.answers << Answer.new(reference: '2', label_en: I18n.t('answers.no'))
    self.save
  end

  # @return name of category
  # Used as method for rendering all unused node in a diagnostic
  def category_name
    if category_id.present?
      category.name
    end
  end

  # @return [Array][Answers]
  # Return answers if any
  def get_answers
    if defined? answers
      answers
    end
  end

  private

  # @params nil
  # @return nil
  # Validate the uniqueness after validation if it is present in order to simulate #complete_reference
  def unique_reference

  end

  # @params nil
  # @return nil
  # Complete the reference with the associated prefix before the entry is created
  def complete_reference

  end
end
