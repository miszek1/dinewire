class MessengerController < ApplicationController
  before_action :authenticate_user!

  # GET /messenger
  # GET /messenger.json
  def index
	query = <<-SQL
		select distinct on (user_id) body, messages.created_at, first_name, last_name
		from messages
		Left Join users on users.id = user_id
		where recipient_id = #{ current_user.id }
		order by user_id, messages.created_at desc
	SQL
	result = ActiveRecord::Base.connection.execute(query)
  end

  # GET /messenger/1
  # GET /messenger/1.json
  def show
	query = <<-SQL
		select *
		from messages
		where
			user_id = #{ current_user.id } and recipient_id = #{ params[:id] }
			or user_id = #{ params[:id] } and recipient_id = #{ current_user.id }
		order by created_at
	SQL
	result = ActiveRecord::Base.connection.execute(query)
  end



end
