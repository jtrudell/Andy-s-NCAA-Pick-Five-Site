require 'ncaa_scrape'

class User < ActiveRecord::Base
  has_many :picks
  has_many :teams, through: :picks
  validates :year, presence: true
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :year, message: 'That name has already been taken.'

  def wins(year)
    self.teams.where(year: year).inject(0) { |total, team| total + team.wins }
  end

  def self.standings(year)
    User.where(year: year).sort_by { |user| user.wins(year) }.reverse
  end
end
