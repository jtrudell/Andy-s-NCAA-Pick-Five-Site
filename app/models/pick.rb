class Pick < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  validates_uniqueness_of :team_id, scope: :user

  def self.generate(user, teams, year)
    team_ids = teams.sort.join(',')
    if User.where(team_choices: team_ids).any?
      user.errors[:base] << 'Someone else already picked those five teams. Please try again, picking at least one different team.'
    elsif previous_season_total_wins(teams, year) > 115
      user.errors[:base] << 'Total wins last season for the teams you selected exceeds 115. Please try again.'
    else
      user.team_choices = team_ids
      teams.each { |team| user.picks.build(team_id: team.to_i) }
    end
  end

  def self.previous_season_total_wins(teams, year)
    old_teams = []
    teams.map do |team_id|
      team = Team.find(team_id)
      old_teams << Team.find_by(year: year - 1, name: team.name)
    end
    puts '*******************'
    puts old_teams
    puts '*******************'
    puts teams
    old_teams.inject(0) { |total, team| total + (team.wins || 0) }
  end
end
