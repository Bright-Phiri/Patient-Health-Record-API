class VitalSign < ApplicationRecord
  belongs_to :patient
  validates :weight, :height, :temp_reading, :diagnosis, presence: true
  validates :weight, :height, :temp_reading, numericality: true
  default_scope {order(created_at: :desc)}
end
