class Bus < ApplicationRecord
  has_many :routes

  validates :seats, presence: true, numericality: { only_integer: true }

  def last_route
    date = routes.maximum('end_date')
    routes.find_by(end_date: date)
  end
end
