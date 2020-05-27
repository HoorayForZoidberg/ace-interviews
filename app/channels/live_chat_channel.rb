class LiveChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "live_chat_channel"
  end

  def unsubscribed
    stop_all_streams
  end
end
