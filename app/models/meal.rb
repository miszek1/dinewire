class Meal < ActiveRecord::Base
  belongs_to :user
  scope :personal_meals, -> (user) { where(user_id: user.id) }
  scope :public_meals, -> (user) { ready_to_eat.where.not(user_id: user.id, flagged_for_review: true) }
  scope :ready_to_eat, -> { where(expires_at: DateTime.now..1.hour.from_now)}
  scope :search, -> (name) { where("lower(name) like?", "%#{name.downcase}%")}
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  attr_accessor :ip_address

  geocoded_by :ip_address
  after_validation :geocode

  def author
    user.full_name
  end 

  def image_url_thumb
    image.url(:thumb)
  end	

  def image_url_medium
    image.url(:medium)
  end

  def image_url_orig
    image.url(:original)
  end

  def flagged?
    flagged_for_review?
  end

  def flag!
    self.flagged_for_review = true
    self.save!
  end

  def as_json(options={})
    super(
      :methods => [:image_url_thumb,:image_url_medium,:image_url_orig,:author]
    )
  end

end

