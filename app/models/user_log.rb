# Log user actions
class UserLog < ApplicationRecord

  belongs_to :user

  after_create :log_create
  before_update :log_update
  before_destroy :log_delete

  # retrieve model from log attributes
  def model
    Object.const_get(model_type).find(model_id)
  end

  private

  def log_create

  end

  def log_update

  end

  def log_delete

  end

end
