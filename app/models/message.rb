class Message < ActiveRecord::Base
  belongs_to :user
  

  def send_message_notification
    MessageNotificationMailer.send_notification(recipient, self)
  end

  def recipient
    User.find (self.recipient_id)
    
  end
end
