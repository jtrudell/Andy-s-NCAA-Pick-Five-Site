require 'ncaa_scrape'

class Team < ActiveRecord::Base
  has_many :picks
  has_many :users, through: :picks
  validates :year, presence: true
  validates :name, presence: true
  validates :wins, presence: true
  validates_uniqueness_of :name, scope: :year
  before_create :zero_wins
  scope :teams_for, ->(year:) { where(year: year).order('name') }

  def self.update_wins(year)
    scrape = NCAABasketball.new
    Team.where(year: year).map do |team|
      updated_wins = scrape.team_wins(team.name)
      team.update(wins: updated_wins) if updated_wins.present?
    end
  end

  private

  def zero_wins
    self.wins = 0 if wins.nil?
  end
end
