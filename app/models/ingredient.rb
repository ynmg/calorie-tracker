class Ingredient < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :calories, presence: true, numericality: {greater_than_or_equal_to: 0}

  has_many :portions
end
