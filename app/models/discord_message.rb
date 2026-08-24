# frozen_string_literal: true

require 'addressable/uri'
require 'google/apis/youtube_v3'

class DiscordMessage
  def call(event)
    @content = event.content
    {
      caption: caption,
      discord_message_id: event.message.id,
      discord_channel_id: event.channel.id,
      title: title,
      url: url,
      thumbnail: thumbnail,
      user_id: event.message.author.id
    }
  end

  private

  def caption
    @content.gsub(URI::DEFAULT_PARSER.make_regexp, '').strip.presence
  end

  def url
    URI::DEFAULT_PARSER.make_regexp.match(@content).to_s
  end

  def parse_url
    Addressable::URI.parse(url)
  end

  def youtube_id
    if url.include?('watch?v=')
      with_v
    elsif url.include?('playlist?list=')
      playlist
    else
      without_v
    end
  end

  def with_v
    parse_url.query_values['v']
  end

  def without_v
    parse_url.to_s.scan(/\w+/)[3]
  end

  def playlist
    parse_url.query_values['list']
  end

  def youtube
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = Rails.application.credentials.youtube[:api_key]
    service
  end

  def title
    response =
      if playlist
        youtube.list_playlists('snippet,contentDetails', id: youtube_id)
      else
        youtube.list_videos('snippet', id: youtube_id)
      end
    response.items.first.snippet.title
  end

  def thumbnail
    response =
      if playlist
        youtube.list_playlists('snippet,contentDetails', id: youtube_id)
      else
        youtube.list_videos('snippet', id: youtube_id)
      end
    response.items.first.snippet.thumbnails.medium.url
  end
end
