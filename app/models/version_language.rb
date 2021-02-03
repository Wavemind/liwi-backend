# Define every languages for one version
class VersionLanguage < ApplicationRecord

  belongs_to :version
  belongs_to :language

end
