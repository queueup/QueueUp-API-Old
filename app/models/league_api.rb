# frozen_string_literal: true

class LeagueApi
  attr_accessor :region,
                :ranked_data,
                :summoner_name,
                :summoner_id,
                :summoner_level,
                :champions,
                :profile_icon_id

  def initialize(props={})
    @summoner_name = props[:summoner_name]
    @region = props[:region]
    @endpoint = get_region_endpoint(@region)
    if props[:summoner_id].nil?
      fetch_summoner_id
    else
      @summoner_id = props[:summoner_id]
    end
  end

  def fetch_ranked_data
    @ranked_data = request_api "lol/league/v3/positions/by-summoner/#{@summoner_id}" unless @summoner_id.nil?
  end

  def fetch_champions
    return if @summoner_id.nil?
    @champions = request_api "lol/champion-mastery/v3/champion-masteries/by-summoner/#{@summoner_id}"
    @champions = @champions[0..4].pluck('championId') unless @champions.nil?
    @champions
  end

  private

  def fetch_summoner_id
    response = request_api "lol/summoner/v3/summoners/by-name/#{@summoner_name}"
    return if response.nil? || response['id'].nil? || response['profileIconId'].nil?
    @profile_icon_id = response['profileIconId']
    @summoner_level = response['summonerLevel']
    @summoner_name = response['name']
    @summoner_id = response['id']
  end

  def get_region_endpoint(region)
    regions = [
      {
        region:   'BR',
        platform:	'BR1',
        endpoint:	'br1.api.riotgames.com'
      },
      {
        region:   'EUNE',
        platform:	'EUN1',
        endpoint:	'eun1.api.riotgames.com'
      },
      {
        region:   'EUW',
        platform:	'EUW1',
        endpoint:	'euw1.api.riotgames.com'
      },
      {
        region:   'JP',
        platform:	'JP1',
        endpoint:	'jp1.api.riotgames.com'
      },
      {
        region:   'KR',
        platform:	'KR',
        endpoint:	'kr.api.riotgames.com'
      },
      {
        region:   'LAN',
        platform:	'LA1',
        endpoint:	'la1.api.riotgames.com'
      },
      {
        region:   'LAS',
        platform:	'LA2',
        endpoint:	'la2.api.riotgames.com'
      },
      {
        region:   'NA',
        platform:	'NA1',
        endpoint:	'na1.api.riotgames.com'
      },
      {
        region:   'OCE',
        platform:	'OC1',
        endpoint:	'oc1.api.riotgames.com'
      },
      {
        region:   'TR',
        platform:	'TR1',
        endpoint:	'tr1.api.riotgames.com'
      },
      {
        region:   'RU',
        platform:	'RU',
        endpoint:	'ru.api.riotgames.com'
      },
      {
        region:   'PBE',
        platform:	'PBE1',
        endpoint:	'pbe1.api.riotgames.com'
      }
    ]
    regions.select {|r| r[:region].casecmp(region.downcase).zero? }.first[:endpoint] unless region.nil?
  end

  def request_api(req)
    if @endpoint.nil?
      nil
    else
      response = HTTParty.get(URI.encode("https://#{@endpoint}/#{req}"),
                              headers: {'X-Riot-Token' => ENV['RIOT_API_KEY']})
      JSON.parse(response.body)
    end
  end
end
