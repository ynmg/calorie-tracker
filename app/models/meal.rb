class Meal < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :date, presence: true

  has_many :portions, dependent: :destroy
  has_many :ingredients, through: :portions
end
