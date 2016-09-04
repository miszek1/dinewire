class Api::V1::MessagesController < ApplicationController
  before_action :authenticate_by_token

  respond_to :json

  def index
    limit = params[:limit] || 10
    messages = Message.where(recipient_id: @current_user.id)

    render json: messages, status: 200
  end

  def show
    message = Message.where(id: params[:id],user: @current_user).first
    if message
      render json: message, status: 200
    else 
      render json: {status: "404", error: "record not found"}, status: 404
    end
  end   

  def create        
    json = params[:body].permit(:subject, :body, :recipient_id)
    message = @current_user.messages.build(json)
    if message.save
      render json: message, status: 200
    else
      render json: {status: "500", error: "record could not be created at this time"}, status: 500
    end
  end

  def destroy
    message = Message.where(id: params[:id],user: @current_user).first
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

