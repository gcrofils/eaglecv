class Notifier < ActionMailer::Base  

  default_url_options[:host] = Settings.host
  
  def password_reset_instructions(user)  
    subject       "Password Reset Instructions" + Settings.application 
    from          Settings.email.from  
    recipients    user.email  
    sent_on       Time.now  
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)  
  end  
  
  # Activation based on http://github.com/matthooks/authlogic-activation-tutorial/
  
  def activation_instructions(user)
    subject       "Activation Instructions"
    from          "Binary Logic Notifier <noreply@binarylogic.com>"
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => register_url(user.perishable_token)
  end

  def activation_confirmation(user)
    subject       "Activation Complete"
    from          "Binary Logic Notifier <noreply@binarylogic.com>"
    recipients    user.email
    sent_on       Time.now
    body          :root_url => root_url
  end
  

end