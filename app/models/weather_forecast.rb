class WeatherForecast < ApplicationRecord
  belongs_to :zip_code

  validates :zip_code_id, presence: true
  validates :current_temp, presence: true, numericality: true
  validates :date, presence: true
  validates :high_temp, :low_temp, numericality: { decimal: true }, allow_nil: true
end

