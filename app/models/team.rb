require 'ncaa_scrape'

class Team < ActiveRecord::Base
  has_many :picks
  has_many :users, through: :picks

  def self.update_wins
    scrape = NCAABasketball.new
    teams = Team.all
    teams.each { |team| team.update(wins: scrape.team_wins(team.name)) }
  end
end
