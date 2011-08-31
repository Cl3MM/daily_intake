class CreateAmounts < ActiveRecord::Migration
  def self.up
    create_table :amounts do |t|
      t.float :ingredientAmount, :default => 0
      t.integer :ingredient_id, :default => 1
      t.integer :meal_id, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :amounts
  end
end
