class VitalSign < ApplicationRecord
  belongs_to :patient
  validates :diagnosis, :weight, :height, :temp_reading, presence: true
  validates :weight, :height, :temp_reading, numericality: true
end
