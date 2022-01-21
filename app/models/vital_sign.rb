class VitalSign < ApplicationRecord
  belongs_to :patient
  validates :diagnosis, presence: true
  validates :weight, :height, :temp_reading, numericality: true #doesn't allow nil values by default
end
