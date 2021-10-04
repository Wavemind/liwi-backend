# Define every language the logic can be translated in
class Language < ApplicationRecord

  # @return [Array] attributes
  # Return a label attribute per available language
  def self.label_params
    Language.pluck(:code).map { |langue| I18n.t('languages.label') + langue }
  end

  # @return [Array] attributes
  # Return a description attribute per available language
  def self.description_params
    Language.pluck(:code).map { |langue| I18n.t('languages.description') + langue }
  end

  def self.language_params(field)
    Language.pluck(:code).map{ |language| "#{field}_#{language}"}
  end
end
