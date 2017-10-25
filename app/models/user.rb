class User < ActiveRecord::Base
  has_many :picks
  has_many :teams, through: :picks
  validates :year, presence: true
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :year, message: 'That name has already been taken.'
  scope :users_for, ->(year:) { where(year: year).order('name') }

  def wins(year)
    teams.where(year: year).inject(0) { |total, team| total + team.wins }
  end

  def self.standings(year)
    User.where(year: year).sort_by { |user| user.wins(year) }.reverse
  end
end
