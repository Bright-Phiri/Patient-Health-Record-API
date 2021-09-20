class VitalSign < ApplicationRecord
  belongs_to :patient
  validates :weight, :height, :temp_reading, :diagnosis, presence: true
end
