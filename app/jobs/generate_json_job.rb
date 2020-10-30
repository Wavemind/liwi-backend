class GenerateJsonJob < ApplicationJob
  queue_as :default

  def perform(version_id)
    version = Version.find(version_id)
    version.loading
    VersionsService.generate_version_hash(version_id)
  end
end
