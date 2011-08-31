class Meal < ActiveRecord::Base
  attr_accessible :name, :date, :time 

  has_many :amounts, :dependent => :destroy
  has_many :ingredients, :through => :amounts
  belongs_to :user
  validates_presence_of :user_id, :message => "Something is odd and will be reported... Please Relog ! :)"
  validates_presence_of :name
  validates_presence_of :date
  validates_presence_of :time

  def arr_to_hash (array, keys)
    h = {}
    array = [0,0,0] unless array.size == keys.size
    # transform query array result into hash
    keys.each.with_index { |x, i| h[x] = array[i]}
    return h
  end

  def self.arr_to_hash (array, keys)
    h = {}
    array = [0,0,0] unless array.size == keys.size
    # transform query array result into hash
    keys.each.with_index { |x, i| h[x] = array[i]}
    return h
  end

  def amount meal_id, ing_id
    joins(:ingredients).
      where("meals.id = ? and ingredients.id = ?", meal_id, ing_id)
      select("amounts.ingredientAmount")
  end

  def update_amount (ingredient, amountVal)
    amount = amounts.find_by_ingredient_id(ingredient.id)
    amount.ingredientAmount = amountVal
    amount.save
  end

  def find_or_create_by_ingredient (ingredient, amountVal)
    amountVal = ( ["", nil].include?(amountVal) ? 0 : amountVal )
    ingredients << ingredient unless ingredients.include? ingredient
    update_amount(ingredient, amountVal)
  end

  def self.totalDailyDetailsOn (date)
    ar = joins(:ingredients).
    where("date = ?", date)
    .select( "sum(amounts.ingredientAmount*ingredients.protein/100) as totalDailyProtein, sum(amounts.ingredientAmount*ingredients.carbs/100) as totalDailyCarbs, sum(amounts.ingredientAmount*ingredients.fat/100) as totalDailyFat ").
    map{ |x| [x.totalDailyProtein, x.totalDailyCarbs, x.totalDailyFat] }.
    flatten

    ar.each_with_index do |a, i|
      ar[i] = (a.nil? ? 0 : a)
    end
    a = [ "totalDailyProtein", "totalDailyCarbs", "totalDailyFat" ]
    arr_to_hash ar, a
  end

  def self.totalDailyCalOn (date)
    joins(:ingredients).
    where("date = ?", date).
    sum("(ingredients.protein*4+ingredients.carbs*4+ingredients.fat*9)*amounts.ingredientAmount/100")
  end

  def totalDetail
    ar = ingredients.select("sum(ingredients.protein*amounts.ingredientAmount/100) AS totalProtein,
             sum(ingredients.carbs*amounts.ingredientAmount/100) AS totalCarbs,
             sum(ingredients.fat*amounts.ingredientAmount/100) AS totalFat").
      map{ |x| [x.totalProtein, x.totalCarbs, x.totalFat] }.
      flatten
    ar.each_with_index{|a,i| ar[i] = (a.nil? ? 0.0 : a) }
    a = [ "totalProtein", "totalCarbs", "totalFat" ]
    arr_to_hash ar, a
  end

  def totalCal
    ingredients.where("amounts.meal_id = ?", id).
      select("sum( ( ingredients.protein*4 + ingredients.carbs*4+ingredients.fat*9)*amounts.ingredientAmount/100) as amountPerMeal").
      map{|x| x.amountPerMeal }[0]
  end

  def totalProtein
    total = 0
    ingredients.each do |ing|
      total += ing.protein * amounts.find_by_ingredient_id(ing.id).ingredientAmount
    end
    total/100
  end

  def totalCarbs
    total = 0
    ingredients.each do |ing|
      total += ing.carbs * amounts.find_by_ingredient_id(ing.id).ingredientAmount
    end
    total/100
  end

  def totalFat
    total = 0
    ingredients.each do |ing|
      total += ing.fat * amounts.find_by_ingredient_id(ing.id).ingredientAmount
    end
    total/100
  end

  def totalCarbs2
    ingredients.where("amounts.meal_id = ?", id).
      select("sum( ingredients.carbs*4*amounts.ingredientAmount/100) as amountPerMeal").map{|x| x.amountPerMeal }[0]
  end

  def totalProtein2
     ingredients.where("amounts.meal_id = ?", id).
      select("sum( ingredients.protein*4*amounts.ingredientAmount/100) as amountPerMeal").map{|x| x.amountPerMeal }[0]
  end
  def totalFat2
     ingredients.where("amounts.meal_id = ?", id).
      select("sum( ingredients.fat*9*amounts.ingredientAmount/100) as amountPerMeal").map{|x| x.amountPerMeal }[0]
  end

  scope :meals_at, lambda { |date| where("date = ?", date) }

end
