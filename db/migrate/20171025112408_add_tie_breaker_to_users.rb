class AddTieBreakerToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :tie_breaker, :null => false, :default => 0
    end
  end
end
