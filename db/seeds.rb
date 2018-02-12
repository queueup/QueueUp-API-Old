# user_s = User.create(email: 'sofiane@qup.com', password: '12345678', password_confirmation: '12345678')
# LeagueProfile.create!(summoner_name: 'SofianeLeFragile', region: 'euw', user: user_s)
# CommunicationDatum.create(type: 'skype', user: user_s, value: 'sofiane')
# user_d = User.create(email: 'damien@qup.com', password: '12345678', password_confirmation: '12345678')
# LeagueProfile.create(summoner_name: 'Tekbird', region: 'euw', user: user_d, roles: ['top', 'jungle'])
# CommunicationDatum.create(type: 'discord', user: user_d, value: 'sofiane')
# user_t = User.create(email: 'thomas@qup.com', password: '12345678', password_confirmation: '12345678')
# CommunicationDatum.create(type: 'teamspeak', user: user_t, value: 'sofiane')
# LeagueProfile.create(summoner_name: 'LeBoulet02', region: 'euw', user: user_t, roles: ['mid', 'jungle'])
# user_r = User.create(email: 'remi@qup.com', password: '12345678', password_confirmation: '12345678')
# LeagueProfile.create(summoner_name: 'remi5151', region: 'euw', user: user_r, roles: ['bottom', 'support'])

# match_d = LeagueMatch.create(swiper: user_s.league_profile, target: user_d.league_profile)
# match_t = LeagueMatch.create(swiper: user_s.league_profile, target: user_t.league_profile)

# LeagueMessage.create(league_match: match_d, content: 'This is a random message', league_profile: user_d.league_profile)

champions = [202, 157, 89, 222, 136, 238, 163, 236]
locales = %w(en_US en_GB sv_SE it_IT es_ES fr_FR)
roles = %w(top jungle mid bottom support)
summoner_names = %w(SofianeLeFragile Tekbird Dernise Clorces Ashubu TheFeedingSpree NightSorrow69 Boopp remi5151 RiverSanzu)
times = [1, 2, 3]
vocal = %w(discord teamspeak skype)

summoner_names.each do |sn|
  user = User.create(email: "#{sn}@queueup.gg", password: '12345678', password_confirmation: '12345678')
  LeagueProfile.create(
    champions: champions.sample(times.sample).uniq,
    description: Faker::LeagueOfLegends.quote,
    locales: locales.sample(times.sample).uniq,
    region: 'euw',
    roles: roles.sample(times.sample).uniq,
    summoner_name: sn,
    user: user
  )
  times.sample.times do |t|
    CommunicationDatum.create(
      user: user,
      type: vocal[t],
      value: sn
    )
  end
end

LeagueProfile.all.each do |l|
  LeagueProfile.where('id != ?', l.id).each do |lp|
    LeagueResponse.create(swiper: l, target: lp, accepted: [true, false].sample)
  end
end
