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
    errors.add(:destination_id, 'Start and destination must not be the same!') if start_id == destination_id
  end

  validate do
    if bus.last_route && start_id != bus.last_route.destination_id
      errors.add(:start_id, 'Start id must be last route destination id!')
    end
  end

  validate do
    if bus.last_route && start_date < (bus.last_route.end_date + 5.minutes)
      errors.add(:start_id, 'Start date must be at least 5 minutes latter than last route end date!')
    end
  end

  validate do
    unless [nil, commute_time].include?(Route.commute_time(start_id, destination_id))
      errors.add(:end_date, 'Commute time must allways be the same!')
    end
  end

  def self.commute_time(point_a_id, point_b_id)
    first_commute = Route.find_by(start_id: [point_a_id, point_b_id], destination_id: [point_a_id, point_b_id])
    first_commute ? (first_commute.end_date - first_commute.start_date).to_i : nil
  end

  def commute_time
    (end_date - start_date).to_i
  end
end
