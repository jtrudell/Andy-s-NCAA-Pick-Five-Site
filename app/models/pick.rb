class Pick < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  def self.generate(user, teams)
    teams.each_value do |team|
      pick = Pick.new(user_id: user.id, team_id: team.to_i)
      if pick.save
        next
      else
        pick.errors.add(:base, 'Try again')
      end
    end
    user.picks
  end
end
