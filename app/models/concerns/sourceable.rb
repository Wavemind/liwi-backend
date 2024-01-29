module Sourceable
  extend ActiveSupport::Concern

  included do
    has_many :duplicates, class_name: self.name, foreign_key: 'source_id', dependent: :nullify
  end
end
