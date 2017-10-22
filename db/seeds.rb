# frozen_string_literal: true

require 'ncaa_scrape'

scrape = NCAABasketball.new

# populate/update team wins for previous season; create teams for current seaason

scrape.team_names.each do |team_name|
  Team.where(name: team_name, year: Time.now.year - 1).first_or_create(name: team_name, wins: 0, year: Time.now.year - 1)
  Team.create(name: team_name, wins: 0, year: Time.now.year)
end
