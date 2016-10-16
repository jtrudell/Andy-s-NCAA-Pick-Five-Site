class Pick < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  validates_uniqueness_of :team_id, scope: :user

  def self.generate(user, teams)
    teams.each_value { |team| user.picks.build(team_id: team.to_i) }
  end

end
