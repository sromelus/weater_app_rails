class ZipCode < ApplicationRecord
    has_many :weather_forecasts, dependent: :destroy

    validates :code, presence: true, uniqueness: true, length: { is: 5 }, numericality: { only_integer: true }
end
