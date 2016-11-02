require 'ncaa_scrape'

class Team < ActiveRecord::Base
  has_many :picks
  has_many :users, through: :picks
  validates :year, presence: true
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :year

  attr_reader :wins

  def self.update_wins(year)
    teams = Team.where(year: year)
    scrape = NCAABasketball.new
    teams.map { |team| team.update(wins: scrape.team_wins(team.name)) }
  end
end
