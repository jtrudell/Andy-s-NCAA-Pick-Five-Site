require 'ncaa_scrape'

class Team < ActiveRecord::Base
  has_many :picks
  has_many :users, through: :picks
  validates :year, presence: true
  validates :name, presence: true
  validates :wins, presence: true
  validates_uniqueness_of :name, scope: :year
  before_create :zero_wins
  scope :teams_for, -> (year:) { where(year: year).order('name') }

  def self.update_wins(year)
    scrape = NCAABasketball.new
    Team.where(year: year).map { |team| team.update(wins: scrape.team_wins(team.name)) }
  end

  private
  def zero_wins
    self.wins = 0 if self.wins.nil?
  end
end
