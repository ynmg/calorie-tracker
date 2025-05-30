class Meal < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, inclusion: {in: %w(Breakfast Lunch Dinner Snack), message: "%{value} is not a valid meal"}
  validates :date, presence: true

  has_many :portions, dependent: :destroy, inverse_of: :meal
  has_many :ingredients, through: :portions

  accepts_nested_attributes_for :portions, allow_destroy: true

  def self.total_calories
    sum { |meal| meal.total_calories }
  end

  def total_calories
    portions.sum { |portion| portion.ingredient.calories * (portion.quantity.to_f / 100) }
  end
end
