class CreateIngredients < ActiveRecord::Migration
  def self.up
    create_table :ingredients do |t|
      t.string :name
      t.string :description
      t.string :brand
      t.integer :category_id, :default => 1
      t.float :protein, :default => 0
      t.float :carbs, :default => 0
      t.float :fat, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :ingredients
  end
end
