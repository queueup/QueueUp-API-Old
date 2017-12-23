class LeagueMessageNotification < NotificationApi
  def initialize(message)
    @message = message
    set_pending_notifications
    cancel
    create
  end

  def create
    Pusher.trigger("chat-#{@message.league_match.id}", 'new_message', @message)
    unless target_devices.empty?
      if @pending_notifications.empty?
        notification_id = create_notification({
          headings: { en: "New message from #{@message.league_profile.summoner_name} !" },
          contents: { en: @message.content },
          include_player_ids: target_devices,
        }) 
      else
        notification_id = create_notification({
          headings: { en: "New messages from your matches !" },
          contents: { en: "#{@pending_notifications.size + 1} new messages" },
          include_player_ids: target_devices,
        }) 
      end
    end
    Notification.create(user: target_user, verb: 'league:message:new', status: :pending, signal_id: notification_id || nil)
  end

  # Cancel all notifications already issued for the same user
  def cancel
    @pending_notifications.each do |notification|
      cancel_notification(notification.signal_id) unless notification.signal_id.nil?
      notification.update(status: :canceled)
    end
  end

  private
  def target_devices
    target_user.devices.pluck(:user_token)
  end

  def target_user
    @message.league_match.swiper_id == @message.league_profile_id ?
      @message.league_match.target.user :
      @message.league_match.swiper.user
  end

  def set_pending_notifications
    @pending_notifications = Notification.pending.where(user: target_user, verb: 'league:message:new')
  end
end
