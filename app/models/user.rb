# frozen_string_literal: true

class User < ApplicationRecord
  def self.find_or_create_from_discord_auth(discord_auth)
    find_or_create_by(uid: discord_auth.uid) do |user|
      user.update(
        name: discord_auth.info.name,
        avator_url: discord_auth.info.image,
        uid: discord_auth.uid,
        provider: discord_auth.provider
      )
    end
  end
end
