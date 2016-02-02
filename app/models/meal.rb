class Meal < ActiveRecord::Base
	belongs_to :user
  scope :personal_meals, -> (user) { where(user_id: user.id) }
  scope :public_meals, -> (user) { where.not(user_id: user.id) }
end
