# frozen_string_literal: true

require_relative '../../config/environment'
require 'discordrb'

class DiscordBot
  CLIENT_ID = Rails.application.credentials.discord[:client_id]
  TOKEN = Rails.application.credentials.discord[:token]

  bot = Discordrb::Bot.new(
    client_id: CLIENT_ID,
    token: TOKEN
  )

  bot.message do |event|
    event.send_message('Hellooooo.')
  end

  bot.run
end
