class CreateWeatherForecasts < ActiveRecord::Migration[7.2]
  def change
    create_table :weather_forecasts do |t|
      t.references :zip_code, null: false, foreign_key: true
      t.string :city
      t.string :state
      t.decimal :current_temp, null: false
      t.decimal :temp_max
      t.decimal :temp_low
      t.datetime :date, null: false
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
