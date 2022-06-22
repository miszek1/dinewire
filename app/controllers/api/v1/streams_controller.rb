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
		where recipient_id = 96
		order by user_id, messages.created_at desc
	SQL
	messages = ActiveRecord::Base.connection.execute(query)
	render json: messages, status: 200
  end

  # GET /Streams/1
  # GET /Streams/1.json
  def show
	query = <<-SQL
		select *, CASE WHEN user_id = 96 THEN 'me' ELSE 'them' END as origin
		from messages
		where
			(user_id = 96 and recipient_id = #{ params[:id] })
			or (user_id = #{ params[:id] } and recipient_id = 96)
		order by created_at
	SQL
	messages = ActiveRecord::Base.connection.execute(query)
	render json: messages, status: 200
  end



end
