class AddYearToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :year, :null => false, :default => Time.now.year
    end
  end
end
