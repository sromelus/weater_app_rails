class WeatherForecast < ApplicationRecord
  belongs_to :zip_code

  validates :city, :state, :current_temp, :date, presence: true
  validates :current_temp, numericality: { decimal: true }
  validates :temp_max, :temp_low, numericality: { decimal: true }, allow_nil: true
  validates :latitude, :longitude, numericality: { decimal: true }, allow_nil: true
  validates :zip_code_id, presence: true
end
