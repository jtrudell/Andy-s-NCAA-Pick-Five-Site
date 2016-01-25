require 'ncaa_scrape'

class User < ActiveRecord::Base
  has_many :picks
  has_many :teams, through: :picks
  validates :name, presence: true

  def wins
    self.teams.inject(0) { |total, team| total + team.wins }
  end

  def self.standings
    @users = User.all
    @users.sort { |x, y| y.wins <=> x.wins }
  end
end
