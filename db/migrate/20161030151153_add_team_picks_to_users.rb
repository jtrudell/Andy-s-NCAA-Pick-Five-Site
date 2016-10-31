class AddTeamPicksToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :team_choices
    end
  end
end
