class WeatherForecast < ApplicationRecord
  belongs_to :zip_code

  validates :zip_code_id, presence: true
  validates :current_temp, presence: true, numericality: true
  validates :date, presence: true
  validates :condition_icon, presence: true
  validates :high_temp, :low_temp, numericality: { decimal: true }, allow_nil: true

  def self.create_or_update_from_api(forecast_data, zip_code)
    zip_code.update!(
      city: forecast_data[:city],
      state: forecast_data[:state],
      latitude: forecast_data[:latitude],
      longitude: forecast_data[:longitude]
    )

    forecast = WeatherForecast.new(zip_code: zip_code, date: Date.today)

    forecast.tap do |f|
      f.current_temp = forecast_data[:current_temp]
      f.high_temp = forecast_data[:high_temp]
      f.low_temp = forecast_data[:low_temp]
      f.condition = forecast_data[:condition]
      f.condition_icon = forecast_data[:condition_icon]
      f.feels_like = forecast_data[:feels_like]
      f.wind_speed = forecast_data[:wind_speed]
      f.last_updated = forecast_data[:last_updated]
      f.save!
    end
  end
end
