class Ticket < ApplicationRecord
  belongs_to :route

  validates :seat_number, presence: true, allow_blank: false
  validates :status, presence: true, inclusion: { in: ['processing', 'processed', 'canceled']  }

  validate :seat_uniqueness

  def seat_uniqueness
    return if status == 'canceled'

    if Ticket.where(route_id: route_id, seat_number: seat_number).where.not(status: 'canceled').present?
      errors.add(:seat, "must be uniq for a route. ")
    end
  end
end
