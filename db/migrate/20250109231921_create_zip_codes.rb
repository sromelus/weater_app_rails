class CreateZipCodes < ActiveRecord::Migration[7.2]
  def change
    create_table :zip_codes do |t|
      t.string :code, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
