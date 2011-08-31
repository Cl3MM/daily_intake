class CreateUserWeightPrefs < ActiveRecord::Migration
  def self.up
    create_table :user_weight_prefs do |t|
      t.date :date
      t.float :weight
      t.integer :user_id
      t.boolean :maintenance, :defaults=>false

      t.timestamps
    end
  end

  def self.down
    drop_table :user_weight_prefs
  end
end
