require 'ncaa_scrape'

class User < ActiveRecord::Base
  has_many :picks
  has_many :teams, through: :picks
  validates :year, presence: true
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :year, message: 'That name has already been taken.'

  def wins
    self.teams.inject(0) { |total, team| total + (team.wins || 0 )}
  end

  def self.standings(year)
    @users = User.where(year: year)
    @users.sort { |x, y| y.wins <=> x.wins }
  end
end
