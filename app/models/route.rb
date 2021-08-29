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

  validate do
    if bus.last_route && start_id != bus.last_route.destination_id
      errors.add(:start_id, 'Start id must be last route destination id!')
    end
  end

  validate do
    if bus.last_route && start_date <= (bus.last_route.end_date + 5.minutes)
      errors.add(:start_id, 'Start date must be at least 5 minutes latter than last route end date!')
    end
  end


end
