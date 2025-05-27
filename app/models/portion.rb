class Portion < ApplicationRecord
  belongs_to :meal
  belongs_to :ingredient

  validates :quantity, presence: true, numericality: {greater_than: 0}
end
