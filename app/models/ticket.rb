class Ticket < ApplicationRecord
  belongs_to :route

  validates :seat_number, presence: true, allow_blank: false, uniqueness: { scope: :route }
  validates :status, presence: true, inclusion: { in: ['processing', 'processed', 'processing']  }
end
