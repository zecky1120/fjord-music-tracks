# frozen_string_literal: true

class Video < ApplicationRecord
  belongs_to :user

  validates :discord_channel_id, :discord_message_id, :title, :youtube_id, :user, presence: true

  def self.create_video_info(discord_message)
    user = User.find_by(uid: discord_message[:user_uid])

    create!(
      caption: discord_message[:caption],
      discord_channel_id: discord_message[:discord_channel_id],
      discord_message_id: discord_message[:discord_message_id],
      youtube_id: discord_message[:youtube_id],
      title: discord_message[:title],
      user: user
    )
  end
end
