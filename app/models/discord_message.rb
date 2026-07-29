# frozen_string_literal: true

class DiscordMessage
  def call(event)
    @content = event.content
    {
      caption: caption,
      youtube_id: youtube_id,
      discord_message_id: event.message.id,
      discord_channel_id: event.channel.id
    }
  end

  private

  def caption
    @content.gsub(URI::DEFAULT_PARSER.make_regexp, '').strip
  end

  def youtube_id
    if extract_url.include?('watch?v=')
      with_v
    elsif extract_url.include?('playlist?list=')
      playlist
    else
      without_v
    end
  end

  def extract_url
    URI::DEFAULT_PARSER.make_regexp.match(@content).to_s
  end

  def uri
    Addressable::URI.parse(extract_url)
  end

  def with_v
    uri.query_values['v']
  end

  def without_v
    uri.to_s.scan(/\w+/)[3]
  end

  def playlist
    uri.query_values['list']
  end
end
