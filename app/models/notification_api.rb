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

  def count_canceled_notifications
    if last_seen_notifications.empty?
      Notification.canceled.where(user: @user, verb: @verb).size
    else
      notifications = Notification.canceled
      notifications = notifications.where(user: @user, verb: @verb)
      notifications = notifications.where('created_at > ?', last_seen_notifications.last.created_at)
      notifications.size
    end
  end

  def last_seen_notifications
    Notification.seen.where(user: @user, verb: @verb).order(:created_at)
  end

  def cancel_previous_notifications
    set_pending_notifications
    @pending_notifications.each do |notification|
      notification.update(status: :canceled)
    end
  end

  def set_pending_notifications
    @pending_notifications = Notification.pending.where(user: @user, verb: @verb)
  end

  def get_devices
    @user.devices.pluck(:user_token)
  end
end
