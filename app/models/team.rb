require 'ncaa_scrape'

class Team < ActiveRecord::Base
  has_many :picks
  has_many :users, through: :picks
  validates :year, presence: true
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :year

  attr_reader :name

  def self.update_wins(year)
    teams = Team.where(year: year)
    if Time.now < Time.new(year, 11)
      teams.each { |team| team.update(wins: 0) }
    elsif Time.now.year > year + 1
      return
    else
      scrape = NCAABasketball.new
      teams.each { |team| team.update(wins: scrape.team_wins(team.name)) }
    end
  end

  def self.two_columns(year)
    teams = Team.where(year: year).order(:name)
    {
      first_half: teams[0...teams.count/2],
      second_half: teams[teams.count/2..-1]
    }
  end
end
