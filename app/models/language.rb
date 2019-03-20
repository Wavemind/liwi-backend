# Define every language the logic can be translated in
class Language < ApplicationRecord

  def self.label_params
    Language.pluck(:code).map { |langue| I18n.t('languages.label') + langue }
  end

  def self.description_params
    Language.pluck(:code).map { |langue| I18n.t('languages.description') + langue }
  end

end
