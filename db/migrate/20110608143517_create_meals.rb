class CreateMeals < ActiveRecord::Migration
  def self.up
    create_table :meals do |t|
      t.string :name
      t.date :date
      t.time :time
      t.boolean :dayOn, :default => false
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :meals
  end
end
