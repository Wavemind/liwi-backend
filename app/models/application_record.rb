class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  after_create :log_create
  before_update :log_update
  before_destroy :log_delete

  def log_create
    user = User.get_current
    UserLog.create(
      user: User.get_current,
      action: 'create',
      model_type: self.class.name,
      model_id: self.id,
      data: self.attributes,
      ip_address: user.ip
    )
  end

  def log_update
    user = User.get_current
    UserLog.create(
      user: User.get_current,
      action: 'update',
      model_type: self.class.name,
      model_id: self.id,
      data: changed_attributes,
      ip_address: user.ip
    )
  end

  def log_delete
    user = User.get_current
    UserLog.create(
      user: user,
      action: 'delete',
      model_type: self.class.name,
      model_id: self.id,
      data: self.attributes,
      ip_address: user.ip
    )
  end

end
