class Route < ApplicationRecord
  belongs_to :bus

  validates :start_date, presence: true, allow_blank: false
  validates :end_date, presence: true, allow_blank: false
  validates :start_id, presence: true, allow_blank: false
  validates :destination_id, presence: true, allow_blank: false

  validate do
     errors.add(:end_date, 'End date must be higher than start date!') unless start_date < end_date
  end

  validate do
     errors.add(:destination_id, 'End date must be higher than start date!') if start_id == destination_id
  end
end
