class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat, only: [:update, :destroy]

  def create
    @chat = current_user.chats_as_sender.new(chat_params)
    if @chat.save
      redirect_to conversation_path(@chat.receiver_id), notice: "Message sent successfully."
    else
      redirect_to conversation_path(chat_params[:receiver_id]), alert: "Failed to send message: #{@chat.errors.full_messages.to_sentence}"
    end
  end

  def conversation
    @receiver = User.find(params[:user_id])
    @chats = Chat.where(sender: current_user, receiver: @receiver)
                 .or(Chat.where(sender: @receiver, receiver: current_user))
                 .order(created_at: :asc)
    render :conversation
  end

  def recent_chats
    @recent_chats = Chat.where(sender: current_user)
                        .or(Chat.where(receiver: current_user))
                        .select(Arel.sql('DISTINCT ON (LEAST(sender_id, receiver_id), GREATEST(sender_id, receiver_id)) *'))
                        .order(Arel.sql('LEAST(sender_id, receiver_id), GREATEST(sender_id, receiver_id), created_at DESC'))
    render :recent_chats
  end

  def update
    if @chat.sender == current_user && @chat.update(chat_params)
      redirect_to conversation_path(@chat.receiver_id), notice: "Message updated successfully."
    else
      redirect_to conversation_path(@chat.receiver_id), alert: "Failed to update message: #{@chat.errors.full_messages.to_sentence}"
    end
  end

  def destroy
    if @chat.sender == current_user
      @chat.destroy
      redirect_to conversation_path(@chat.receiver_id), notice: "Message deleted successfully."
    else
      redirect_to conversation_path(@chat.receiver_id), alert: "Unauthorized action."
    end
  end

  private

  def chat_params
    params.permit(:original_message, :translated_message, :language, :receiver_id)
  end

  def set_chat
    @chat = Chat.find(params[:id])
  end
end
