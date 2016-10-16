class AddYearToTeams < ActiveRecord::Migration
  def change
    change_table :teams do |t|
      t.integer :year, :null => false, :default => Time.now.year
    end
  end
end
