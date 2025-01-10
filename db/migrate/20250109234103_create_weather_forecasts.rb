class CreateWeatherForecasts < ActiveRecord::Migration[7.2]
  def change
    create_table :weather_forecasts do |t|
      t.references :zip_code, null: false, foreign_key: true
      t.decimal :current_temp, null: false
      t.decimal :high_temp
      t.decimal :low_temp
      t.datetime :date, null: false
      t.string :condition
      t.string :condition_icon
      t.string :feels_like
      t.string :wind_speed
      t.string :last_updated

      t.timestamps
    end
  end
end
