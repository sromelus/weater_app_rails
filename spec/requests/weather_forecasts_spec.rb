require 'rails_helper'

RSpec.describe "WeatherForecasts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/weather_forecasts"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /weather_forecasts/search" do
    let(:valid_address) { "123 Main St, New York, NY" }
    let(:mock_result) do
      OpenStruct.new(
        success?: true,
        data: {
          weather_forecast: build(:weather_forecast),
          cache_hit: false,
          location: OpenStruct.new(
            latitude: 40.7128,
            longitude: -74.0060,
            postal_code: "10001"
          )
        }
      )
    end

    before do
      allow(WeatherLookupService).to receive(:new)
        .and_return(double(perform: mock_result))
    end

    context "with valid address" do
      it "performs weather lookup and renders index" do
        get "/weather_forecasts/search", params: { address: valid_address }

        expect(response).to have_http_status(:success)
        expect(assigns(:weather_forecast)).to be_present
        expect(assigns(:latitude)).to eq(40.7128)
        expect(assigns(:longitude)).to eq(-74.0060)
        expect(assigns(:zipcode)).to eq("10001")
      end
    end

    context "with invalid address" do
      let(:mock_error_result) do
        OpenStruct.new(
          success?: false,
          error: "Invalid address"
        )
      end

      before do
        allow(WeatherLookupService).to receive(:new).and_return(double(perform: mock_error_result))
      end

      it "sets flash error and renders index" do
        get "/weather_forecasts/search", params: { address: "invalid" }

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
        expect(flash.now[:alert]).to eq("Invalid address")
      end
    end
  end
end
