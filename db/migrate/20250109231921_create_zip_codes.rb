class CreateZipCodes < ActiveRecord::Migration[7.2]
  def change
    create_table :zip_codes do |t|
      t.string :code, null: false, index: { unique: true }
      t.string :city
      t.string :state
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
