class Message < ActiveRecord::Base
  extend ActsAsTree::TreeWalker
  extend ActsAsTree::TreeView
  belongs_to :user
  acts_as_tree order: "id"
 

  def author
    user.full_name
  end 

  def send_message_notification
    MessageNotificationMailer.send_notification(recipient, self).deliver_now
  end

  def recipient
    User.find (self.recipient_id)
  end

  def parentMessage
    if !self.parent_id.nil?
      Message.find (self.parent_id)
    end
  end

  def as_json(options={})
    super(
      :methods => [:author]
    )
  end
end
