class User < ActiveRecord::Base
  acts_as_authentic
  attr_accessible :username, :email, :dob, :password, 
                  :password_confirmation, :share_ingredient
  has_many :meals
  has_many :weights
end
