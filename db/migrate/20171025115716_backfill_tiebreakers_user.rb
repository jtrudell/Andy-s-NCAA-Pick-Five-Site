class BackfillTiebreakersUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      User.find_each do |user|
        user.tie_breaker = 0
        user.save!
      end
    end
  end
end
