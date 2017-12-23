class LeagueMatchNotification < NotificationApi
  def initialize(match)
    @match = match
    create
  end

  def create
    Pusher.trigger("match-#{@match.target.id}", 'new_match', @match)
    unless target_devices.empty?
      notification_id = create_notification({
        headings: {en: 'You just got a match !'},
        contents: {en: "You just matched with #{@match.swiper.summoner_name}"},
        include_player_ids: target_devices,
      })
    end
    Notification.create(user: target_user, verb: 'league:match:new', status: :pending, signal_id: notification_id || nil)
  end

  private
  def target_devices
    target_user.devices.pluck(:user_token)
  end

  def target_user
    @match.target.user
  end
end
