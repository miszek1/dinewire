class Api::V1::MessagesController < ApplicationController
  before_action :authenticate_by_token
  include HTTParty
  respond_to :json

  # Create new file to storage log of pushes.
  @push_logger = ::Logger.new(Rails.root.join('log', 'push.log'))

  # Every request needs to inform the APP ID.
  HEADERS = { "Authorization" => "Basic ZDc1Yjk2MTctNmVlNC00YzQ1LTlkYTAtMjhlOWIzMDVmOTE0", "Content-Type" => "application/json" }

  @body =  {
    "app_id" => '66e1b37a-7fb4-4da5-a4e7-432a296a240d'
  }

  def index
    limit = params[:limit] || 10
    messages = Message.where(recipient_id: @current_user.id).order( 'created_at DESC' )
    render json: messages, status: 200
  end

  def show
    message = Message.where(id: params[:id], recipient_id: @current_user.id).first
    if message
      render json: message, status: 200
    else 
      render json: {status: "404", error: "record not found"}, status: 404
    end
  end   

  def create        
    json = params[:body].permit(:subject, :body, :recipient_id, :parent_id)
    message = @current_user.messages.build(json)
    if message.save
      push_body = { 
        "app_id" => '66e1b37a-7fb4-4da5-a4e7-432a296a240d',
        "include_external_user_ids" => [json['recipient_id']],
        "data" => { "type": "new_message" },
        "headings" => { "en" => 'From: ' + @current_user.full_name() },
        "contents" => { "en" => json['body']}
      }.to_json
      HTTParty.post "https://onesignal.com/api/v1/notifications", headers: HEADERS, body: push_body, logger: @push_logger, log_level: :debug, log_format: :curl
      render json: message, status: 200
    else
      render json: {status: "500", error: "record could not be created at this time"}, status: 500
    end
  end

  def destroy
    message = Message.where(id: params[:id]).first
    if message
      message.delete
      render json: {status: "200", message: "record successfully deleted"}, status: 200
    else 
      render json: {status: "404", error: "record not found"}, status: 404
    end
  end

  def update
    message = Message.where(id: params[:id],user: @current_user).first
    json = params[:body].permit(:subject, :body, :recipient_id)
    if message
      message.update(json)
      render json: message, status: 200
    else
      render json: {status: "404", error: "record not found"}, status: 404
  end

end
end
