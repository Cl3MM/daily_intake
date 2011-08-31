class Amount < ActiveRecord::Base

  belongs_to :meal
  belongs_to :ingredient

  validates_presence_of :meal_id
  validates_presence_of :ingredient_id
  validates_uniqueness_of :ingredient_id, :scope => :meal_id

  validate :selected_meal_exists
  validate :selected_ingredient_exists
  
  def selected_meal_exists
    errors.add(:meal_id, "This meal doesn't exists") if
      Meal.find_by_id(meal_id).nil?
  end
  def selected_ingredient_exists
    errors.add(:ingredient_id, "This ingredient doesn't exists") if
      Ingredient.find_by_id(ingredient_id).nil?
  end
end
