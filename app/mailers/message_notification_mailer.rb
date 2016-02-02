class MessageNotificationMailer < ActionMailer::Base
  default from: 'notifications@example.com'
  def send_notification(user, message)
    @user = user
    @message = message
    mail(to: @user.email, subject: 'You have a new message!')
  end
end