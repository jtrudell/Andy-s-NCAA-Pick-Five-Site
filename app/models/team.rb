require 'ncaa_scrape'

class Team < ActiveRecord::Base
  has_many :picks
  has_many :users, through: :picks
  validates :year, presence: true
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :year

  def self.update_wins(year)
    teams = Team.where(year: year)
    scrape = NCAABasketball.new
    teams.map { |team| team.update(wins: scrape.team_wins(team.name)) }
  end

  def self.two_columns(year)
    teams = Team.where(year: year).order('name')
    {
      first_half: teams[0...teams.count/2],
      second_half: teams[teams.count/2..-1]
    }
  end
end
