class Pick < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  validates_uniqueness_of :team_id, scope: :user

  IDENTICAL_PICKS_MESSAGE =
    'Someone else already picked those five teams.
     Please try again, picking at least one different team.'.freeze

  TOTAL_WINS_MESSAGE =
    'Total wins last season for the teams you selected exceeds 115.
     Please try again.'.freeze

  def self.generate(user, team_ids, year)
    team_list = team_ids.sort.join(',')
    return if bad_picks(user, team_list, team_ids, year)
    user.team_choices = team_list
    team_ids.map { |team_id| user.picks.build(team_id: team_id.to_i) }
  end

  def self.previous_season_total_wins(team_ids, year)
    last_year_teams = team_ids.map do |team_id|
      team = Team.find(team_id)
      Team.find_by(year: year - 1, name: team.name) if team.present?
    end
    last_year_teams.inject(0) { |total, team| total + team.wins }
  end

  def self.bad_picks(user, team_list, team_ids, year)
    return user.errors[:base] << IDENTICAL_PICKS_MESSAGE if User.where(team_choices: team_list).any?
    return user.errors[:base] << TOTAL_WINS_MESSAGE if previous_season_total_wins(team_ids, year) > 115
  end
end
