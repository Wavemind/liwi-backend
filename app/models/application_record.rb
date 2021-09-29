class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  after_create :log_create
  before_update :log_update
  before_destroy :log_delete

  def log_create
    UserLog.create(
      user: User.get_current,
      action: 'create',
      model_type: self.class.name,
      model_id: self.id,
      data_after: self.attributes,
      ip_address: User.get_current_ip
    )
  end

  def log_update
    unless changes.keys == %w(reference updated_at) || changes.keys.include?("position_x") || changes.keys.include?("position_y")
      UserLog.create(
        user: User.get_current,
        action: 'update',
        model_type: self.class.name,
        model_id: self.id,
        data_before: changed_attributes,
        data_after: changes,
        ip_address: User.get_current_ip
      )
    end
  end

  def log_delete
    UserLog.create(
      user: User.get_current,
      action: 'delete',
      model_type: self.class.name,
      model_id: self.id,
      data_before: self.attributes,
      ip_address: User.get_current_ip
    )
  end

end
