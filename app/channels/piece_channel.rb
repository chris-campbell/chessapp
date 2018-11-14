class PieceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "piece_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
