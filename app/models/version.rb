# Version of an algorithm with its logic
class Version < ApplicationRecord

  belongs_to :algorithm
  belongs_to :user

  has_many :diagnostics, dependent: :destroy
  has_many :medical_case_answers

  has_many :group_accesses
  has_many :groups, through: :group_accesses

  validates_presence_of :name

  validates_uniqueness_of :name, scope: :algorithm

  amoeba do
    enable
    include_association :diagnostics
    append name: I18n.t('duplicated')
  end

  # @return [String]
  # Return a displayable string for this version
  def display_label
    "#{algorithm.name} - #{name}"
  end

end
