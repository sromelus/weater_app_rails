require 'rails_helper'

RSpec.describe ZipCode, type: :model do
  let!(:zip_code) { create(:zip_code, code: 12345) }

  describe "validations" do
    it { should have_many(:weather_forecasts).dependent(:destroy) }
    it { should validate_presence_of(:code) }
    it { should validate_uniqueness_of(:code).case_insensitive }
    it { should validate_length_of(:code).is_equal_to(5) }
    it { should validate_numericality_of(:code).only_integer }
  end
end
