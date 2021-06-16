class DuplicateVersionJob < ApplicationJob
  queue_as :default

  def perform(version_id)
    Version.find(version_id).duplicate
  end
end
