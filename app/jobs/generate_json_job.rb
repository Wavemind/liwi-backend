class GenerateJsonJob < ApplicationJob
  queue_as :default

  after_perform  do |job|
    Version.find(job.arguments.first).update(generating: false)
  end

  # If you're wondering where the fuck "arguments" comes from, it would appear that it is an array of the arguments passed to the perform action below.
  # You won't find it in the docs
  rescue_from(StandardError) do |exception|
    version_id = arguments[0]
    Version.find(version_id).update(generating: false)
  end

  def perform(version_id)
    VersionsService.generate_version_hash(version_id)
  end
end
