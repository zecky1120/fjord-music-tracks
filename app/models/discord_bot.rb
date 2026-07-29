# frozen_string_literal: true

require 'discordrb'

class DiscordBot
  def initialize
    @bot = Discordrb::Bot.new(
      client_id: Rails.application.credentials.discord[:client_id],
      token: Rails.application.credentials.discord[:token]
    )
  end

  def run
    @bot.message do |event|
      p DiscordMessage.new.call(event)
    end
    @bot.run
  end
end
