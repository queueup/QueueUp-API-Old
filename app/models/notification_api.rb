class NotificationApi
  private
  def create_notification(options)
    params = options.merge({ app_id: ENV['ONESIGNAL_APP_ID'] })
    uri = URI.parse('https://onesignal.com/api/v1/notifications')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    
    request = Net::HTTP::Post.new(uri.path,
                                  'Content-Type'  => 'application/json;charset=utf-8',
                                  'Authorization' => "Basic #{ENV['ONESIGNAL_API_KEY']}")
    request.body = params.as_json.to_json
    response = http.request(request) 
    JSON.parse(response.body)['id']
  end

  def cancel_notification(notification_id)
    params = { app_id: ENV['ONESIGNAL_APP_ID'] }
    uri = URI.parse("https://onesignal.com/api/v1/notifications/#{notification_id}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    
    request = Net::HTTP::Delete.new(uri.path,
                                  'Content-Type'  => 'application/json;charset=utf-8',
                                  'Authorization' => "Basic #{ENV['ONESIGNAL_API_KEY']}")
    request.body = params.as_json.to_json
    response = http.request(request)
  end
end
