class Message < ActiveRecord::Base
  extend ActsAsTree::TreeWalker
  extend ActsAsTree::TreeView
  belongs_to :user
  acts_as_tree order: "id"
 

  def send_message_notification
    MessageNotificationMailer.send_notification(recipient, self).deliver_now
  end

  def recipient
    User.find (self.recipient_id)
    
  end
end
