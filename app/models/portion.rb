class Portion < ApplicationRecord
  belongs_to :meal, inverse_of: :portions
  belongs_to :ingredient

  validates :quantity, presence: true, numericality: {greater_than: 0}

  scope :persisted, -> { where.not(id: nil) }
end
