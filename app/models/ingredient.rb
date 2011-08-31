class Ingredient < ActiveRecord::Base
  has_many :amounts, :dependent => :destroy
  has_many :meals, :through => :amounts

  alias_attribute :p, :protein
  alias_attribute :c, :carbs
  alias_attribute :f, :fat

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_numericality_of :protein
  validates_numericality_of :carbs
  validates_numericality_of :fat

  def cal
    protein*4 + carbs*4 + fat*9
  end

end
