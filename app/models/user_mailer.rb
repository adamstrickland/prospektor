class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://sales.trigonsolutions.com/activate/#{user.activation_code}"
  
  end
  
  def welcome_letter(user)
    setup_email(user, :subject => 'Welcome to Trigon Solutions')
  end

  def termination_letter(user)
    setup_email(user, :subject => 'Suspension of Prospektor Access Rights')
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://sales.trigonsolutions.com/"
  end
  
  def reset_password(user)
    setup_email(user)
    @subject += 'Your password has been reset'
  end
  
  protected
    def setup_email(user, options={})
      @recipients = options[:recipients] || "#{user.email}"
      @from = options[:from] ||"Trigon Solutions"
      @subject = options[:subject] || "Trigon Onboarding"
      @sent_on = Time.now
      @body[:user] = user
    end
end
