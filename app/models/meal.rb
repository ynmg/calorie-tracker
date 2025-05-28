class Meal < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, inclusion: {in: %w(Breakfast Lunch Dinner Snack), message: "%{value} is not a valid meal"}
  validates :date, presence: true

  has_many :portions, dependent: :destroy
  has_many :ingredients, through: :portions
end
