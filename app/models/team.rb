require 'ncaa_scrape'

class Team < ActiveRecord::Base
  has_many :picks
  has_many :users, through: :picks
  validates :name, presence: true, uniqueness: true

  def self.update_wins
    scrape = NCAABasketball.new
    teams = Team.all
    teams.each { |team| team.update(wins: scrape.team_wins(team.name)) }
  end

  def self.two_columns
    teams = Team.all.sort { |x, y| x.name <=> y.name }
    {
      first_half: teams[0...teams.count/2],
      second_half: teams[teams.count/2..-1]
    }
  end
end
