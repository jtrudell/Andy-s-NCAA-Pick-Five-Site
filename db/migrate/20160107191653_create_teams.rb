class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, {null: false}
      t.integer :wins
    end
  end
end
