# frozen_string_literal: true

require 'ncaa_scrape'

scrape = NCAABasketball.new

scrape.team_names.each do |team|
  today = Time.now
  season_start = Time.new(2017, 11, 1)
  if today < season_start
    Team.create(name: team, wins: scrape.team_wins(team), year: Time.now.year - 1)
  end
  Team.create(name: team, wins: 0, year: Time.now.year)
end
