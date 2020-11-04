class GenerateJsonJob < ApplicationJob
  queue_as :default

  after_perfrom do |job|
    Version.find(job.arguments.first).update(generating:false)
  end

  def perform(version_id)
    VersionsService.generate_version_hash(version_id)
  end
end
