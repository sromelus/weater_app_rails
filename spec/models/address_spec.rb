require 'rails_helper'

RSpec.describe Address do
  describe '#initialize' do
    context 'with full address' do
      let(:address) { Address.new('123 Main St, Portland, OR 97201') }

      it 'parses street, city, and state_zip correctly' do
        expect(address.street).to eq('123 Main St')
        expect(address.city).to eq('Portland')
        expect(address.state_zip).to eq('OR 97201')
      end
    end

    context 'with city and state only' do
      let(:address) { Address.new('Portland, OR 97201') }

      it 'parses city and state_zip correctly' do
        expect(address.street).to be_nil
        expect(address.city).to eq('Portland')
        expect(address.state_zip).to eq('OR 97201')
      end
    end
  end

  describe 'validations' do
    subject { Address.new('123 Main St, Portland, OR 97201') }

    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state_zip) }
  end

  describe '#parse' do
    context 'with nil values in address' do
      let(:address) { Address.new(',,') }

      it 'handles nil values gracefully' do
        expect(address.street).to be_nil
        expect(address.city).to be_nil
        expect(address.state_zip).to be_nil
      end
    end

    context 'with extra whitespace' do
      let(:address) { Address.new('  123 Main St  ,  Portland  ,  OR 97201  ') }

      it 'strips whitespace from all components' do
        expect(address.street).to eq('123 Main St')
        expect(address.city).to eq('Portland')
        expect(address.state_zip).to eq('OR 97201')
      end
    end
  end
end
