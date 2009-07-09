class User < ActiveRecord::Base
  
  Admin = 'admin'
  
  acts_as_authentic do |c|
    c.validates_length_of_password_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
    c.validates_length_of_password_confirmation_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
  end
  
  # Authorization plugin
  acts_as_authorized_user
  acts_as_authorizable
  
    
  attr_accessible :username, :email, :password, :password_confirmation, :openid_identifier
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
  
  # Activation based on http://github.com/matthooks/authlogic-activation-tutorial/
  
  def active?
    active
  end
  
  def activate!
    self.active = true
    save
  end
  
  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end

  def deliver_activation_confirmation!
    reset_perishable_token!
    Notifier.deliver_activation_confirmation(self)
  end
  
  def has_no_credentials?
    self.crypted_password.blank? # && self.openid_identifier.blank?
  end
  
  def signup!(params)
    self.username = params[:user][:username]
    self.email = params[:user][:email]
    save_without_session_maintenance
  end
  
  def activate!(params)
    self.active = true
    self.password = params[:user][:password]
    self.password_confirmation = params[:user][:password_confirmation]
    #self.openid_identifier = params[:user][:openid_identifier]
    save
  end
  
  
  
end
