# frozen_string_literal: true

class Video < ApplicationRecord
  belongs_to :user

  validates :discord_channel_id, :discord_message_id, :title, :url, :user, presence: true

  def self.create_video_info(discord_message)
    user = User.find_by(uid: discord_message[:user_id])

    create!(
      **discord_message,
      user: user
    )
  end
end
