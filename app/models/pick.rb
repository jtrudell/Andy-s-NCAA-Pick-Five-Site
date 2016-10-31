class Pick < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  validates_uniqueness_of :team_id, scope: :user

  def self.generate(user, teams)
    team_ids = teams.sort.join(',')
    if User.where(team_choices: team_ids).any?
      user.errors[:base] << 'Someone else already picked those five teams. Please try again, picking at least one different team.'
    else
      user.team_choices = team_ids
      teams.each { |team| user.picks.build(team_id: team.to_i) }
    end
  end
end
