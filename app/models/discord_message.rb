# frozen_string_literal: true

class DiscordMessage
  def call(event)
    message = {
      caption: event.content,
      discord_message_id: event.message.id,
      discord_channel_id: event.channel.id
    }
  end
end
