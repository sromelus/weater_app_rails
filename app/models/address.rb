class Address
    include ActiveModel::Model

    attr_accessor :address, :street, :city, :state_zip

    def initialize(address)
        @address = address
        @street = parse[:street]
        @city = parse[:city]
        @state_zip = parse[:state_zip]
    end

    validates :address, :city, :state_zip, presence: true
    validate :state_zip_valid?

    def parse
        address = @address.split(",")

        if address.length == 2
            {
                city: address[0]&.strip,
                state_zip: address[1]&.strip
            }
        else
            {
                street: address[0]&.strip,
                city: address[1]&.strip,
                state_zip: address[2]&.strip
            }
        end
    end

    def formatted_address
        "#{@city}, #{@state_zip}"
    end

    private

    def state_zip_valid?
        return if @state_zip.nil?
        unless @state_zip.match?(/\A.*\d{5}/)
            errors.add(:address, "is invalid, please use the format 'Street, City, State Zip' or 'City, State Zip'")
        end
    end
end
