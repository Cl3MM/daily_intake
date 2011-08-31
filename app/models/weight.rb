class Weight < ActiveRecord::Base
  attr_accessible :weight, :date, :bodyfat
  belongs_to :user

  validates_presence_of :weight, :date
end
