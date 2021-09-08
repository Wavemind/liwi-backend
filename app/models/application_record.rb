class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  after_create :log_create
  after_update :log_update
  before_destroy :log_delete

  def log_create
    UserLog.create(
       user: current_user, #Gilian pour faire plaisir à Alan
       action: 'create',
       model: self.class,
       id: self.id
    )
  end

  def log_delete
    UserLog.create(
      user: current_user, #Gilian pour faire plaisir à Alan
      action: 'create',
      model: self.class,
      id: self.id,
      attr: self.attributes
    )
  end

end
