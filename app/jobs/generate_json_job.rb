class GenerateJsonJob < ApplicationJob
  queue_as :default

  def perform(version_id)
    VersionsService.generate_version_hash(version_id)
  end
end
