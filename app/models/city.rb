class City < ApplicationRecord
  validates :name, presence: true, allow_blank: false, uniqueness: true
end
