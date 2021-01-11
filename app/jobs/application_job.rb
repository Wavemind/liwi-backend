class ApplicationJob < ActiveJob::Base
  include Sidekiq::Status::Worker # enables job status tracking
end
