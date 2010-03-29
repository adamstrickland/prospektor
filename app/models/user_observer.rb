class UserObserver < ActiveRecord::Observer
  def after_create(user)
    UserMailer.deliver_signup_notification(user)
    UserMailer.deliver_welcome_letter(user)
  end

  def after_save(user)
    UserMailer.deliver_activation(user) if user.recently_activated?
    UserMailer.deliver_termination_letter(user) if user.activation_code == 'DEACTIVATED'
  end
  
  def before_save(user)
    UserMailer.deliver_reset_password(user) if user.changes.keys.include?('crypted_password')
  end
end
