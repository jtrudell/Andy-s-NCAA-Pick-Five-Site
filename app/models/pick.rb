class Pick < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  validates :team_id, presence: true

  def self.generate(user, teams)
    teams.each_value { |team| user.picks.build(team_id: team.to_i) }
    if user.save
      user.picks
    else
      user.errors.add(:user, 'Something went wrong')
      false
    end
  end

end
