class Bus < ApplicationRecord
  validates :seats, presence: true, numericality: { only_integer: true }
end
