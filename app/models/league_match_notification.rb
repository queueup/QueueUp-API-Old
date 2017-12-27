class LeagueMatchNotification < NotificationApi
  def initialize(match)
    @match = match
    @verb = "league:match:new"
    @user = @match.target.user
    cancel_previous_notifications
    create
  end

  def create
    Pusher.trigger("match-#{@match.target.id}", 'new_match', @match)
    unless get_devices.empty?
      if @pending_notifications.empty?
        notification_id = create_notification({
          headings: {
            de: 'Neuer Match',
            en: 'New match',
            fr: 'Nouveau match',
            nl: 'Nieuwe match',
            ru: 'Новое соответствие'
          },
          contents: {
            de: "Du wurdest mit #{@match.swiper.summoner_name} gematched",
            en: "You just matched with #{@match.swiper.summoner_name}",
            fr: "Vous venez de matcher avec #{@match.swiper.summoner_name}",
            nl: "Je matchte zojuist met #{@match.swiper.summoner_name}",
            ru: "Ваш выбор только что совпал с #{@match.swiper.summoner_name}"
          },
          include_player_ids: get_devices,
          ios_badgeType: 'Increase',
          ios_badgeCount: 1,
          collapse_id: @verb
        })
      else
        notification_id = create_notification({
          headings: {
            de: 'Neue Matches',
            en: 'New matches',
            fr: 'Nouveaux matches',
            nl: 'Nieuwe matches',
            ru: 'Новые соответствия'
          },
          contents: {
            de: "Du wurdest mit #{count_canceled_notifications + 1} Beschwörern gematched",
            en: "You matched with #{count_canceled_notifications + 1} summoners",
            fr: "Vous avez matché avec #{count_canceled_notifications + 1} invocateurs",
            nl: "Je matchte met #{count_canceled_notifications + 1} summoners",
            ru: "Ваши выборы совпали с #{count_canceled_notifications + 1} призывателей"
          },
          include_player_ids: get_devices,
          collapse_id: @verb
        }) 
      end
    end
    Notification.create(user: @user, verb: @verb, status: :pending, signal_id: notification_id || nil)
  end
end
