class LiveChatsController < ApplicationController
  def create
    head :no_content
    ActionCable.server.broadcast "live_chat_channel", live_chats_params
  end
    
  private
    
  def live_chats_params
    params.require(:live_chat).permit(:type, :from, :to, :sdp, :candidate)
  end
end
