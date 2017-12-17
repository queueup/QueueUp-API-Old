class NotificationApi
  def self.create_match_notification(match)
    Pusher.trigger("match-#{match.target.id}", 'new_match', match)
    user_tokens = match.target.user.devices.pluck(:user_token)
    create_request({
      headings: {en: 'You just got a match !'},
      contents: {en: "You just matched with #{match.swiper.summoner_name}"},
      include_player_ids: user_tokens
    }) unless user_tokens.empty?
  end

  def self.create_message_notification(message)
    Pusher.trigger("chat-#{message.league_match.id}", 'new_message', message)
    user_tokens = (message.league_match.swiper_id == message.league_profile_id ?
      message.league_match.target.user.devices.pluck(:user_token) :
      message.league_match.swiper.user.devices.pluck(:user_token))
    create_request({
      headings: { en: "New message from #{message.league_profile.summoner_name}" },
      contents: { en: message.content },
      include_player_ids: user_tokens
    }) unless user_tokens.empty?
  end

  private
  def self.create_request(options)
    params = options.merge({ app_id: ENV['ONESIGNAL_APP_ID'] })
    uri = URI.parse('https://onesignal.com/api/v1/notifications')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    
    request = Net::HTTP::Post.new(uri.path,
                                  'Content-Type'  => 'application/json;charset=utf-8',
                                  'Authorization' => "Basic #{ENV['ONESIGNAL_API_KEY']}")
    request.body = params.as_json.to_json
    response = http.request(request) 
    puts response.body
  end
end
