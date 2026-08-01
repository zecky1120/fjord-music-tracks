# frozen_string_literal: true

require 'google/apis/youtube_v3'

class Video < ApplicationRecord
  belongs_to :user

  youtube = Google::Apis::YoutubeV3::YouTubeService.new
  youtube.key = Rails.application.credentials.youtube[:api_key]

end
