# frozen_string_literal: true

class LeagueMessageNotification < NotificationApi
  def initialize(message)
    @message = message
    @verb = "league:message:new:#{@message.league_match.id}"
    @user = if @message.league_match.swiper_id == @message.league_profile_id
              @message.league_match.target.user
            else
              @message.league_match.swiper.user
            end
    cancel_previous_notifications
    create
  end

  def create
    Pusher.trigger("chat-#{@message.league_match.id}", 'new_message', @message)
    unless devices.empty?
      notification_id = if @pending_notifications.empty?
                          create_notification(
                            headings:           {
                              de: "Neue Nachricht von #{@message.league_profile.summoner_name}",
                              en: "New message from #{@message.league_profile.summoner_name}",
                              fr: "Nouveau message de #{@message.league_profile.summoner_name}",
                              nl: "Nieuw bericht van #{@message.league_profile.summoner_name}",
                              ru: "Новое сообщение от #{@message.league_profile.summoner_name}"
                            },
                            contents:           {
                              de: @message.content,
                              en: @message.content,
                              fr: @message.content,
                              nl: @message.content,
                              ru: @message.content
                            },
                            include_player_ids: devices,
                            ios_badgeType:      'Increase',
                            ios_badgeCount:     1,
                            collapse_id:        @verb
                          )
                        else
                          create_notification(
                            headings:           {
                              de: "Neue Nachrichten von #{@message.league_profile.summoner_name}",
                              en: "New messages from #{@message.league_profile.summoner_name}",
                              fr: "Nouveaux messages de #{@message.league_profile.summoner_name}",
                              nl: "Nieuwe berichten van #{@message.league_profile.summoner_name}",
                              ru: "Новые сообщения от #{@message.league_profile.summoner_name}"
                            },
                            contents:           {
                              de: "#{count_canceled_notifications + 1} neue Nachrichten",
                              en: "#{count_canceled_notifications + 1} new messages",
                              fr: "#{count_canceled_notifications + 1} nouveaux messages",
                              nl: "#{count_canceled_notifications + 1} nieuwe berichten",
                              ru: "#{count_canceled_notifications + 1} новых сообщений"
                            },
                            include_player_ids: devices,
                            collapse_id:        @verb
                          )
                        end
    end
    Notification.create(user: @user, verb: @verb, status: :pending, signal_id: notification_id || nil)
  end
end
