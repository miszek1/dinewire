class Api::V1::StreamsController < ApplicationController
	before_action :authenticate_by_token
	respond_to :json

  # GET /Streams
  # GET /Streams.json
  def index
	query = <<-SQL
		select distinct on (user_id) user_id, body, messages.created_at, first_name, last_name
		from messages
		Left Join users on users.id = user_id
		where recipient_id = #{ @current_user.id }
		order by user_id, messages.created_at desc
	SQL
	messages = ActiveRecord::Base.connection.execute(query)
	render json: messages, status: 200
  end

  # GET /Streams/1
  # GET /Streams/1.json
  def show
	if params[:check]
		query = <<-SQL
			select count(*)
			from messages
			where
				(user_id = #{ @current_user.id } and recipient_id = #{ params[:id] })
				or (user_id = #{ params[:id] } and recipient_id = #{ @current_user.id })
		SQL
	else
		query = <<-SQL
			select *, CASE WHEN user_id = #{ @current_user.id } THEN 'me' ELSE 'them' END as origin
			from messages
			where
				(user_id = #{ @current_user.id } and recipient_id = #{ params[:id] })
				or (user_id = #{ params[:id] } and recipient_id = #{ @current_user.id })
			order by created_at
		SQL
	end
	messages = ActiveRecord::Base.connection.execute(query)
	render json: messages, status: 200
  end



end
