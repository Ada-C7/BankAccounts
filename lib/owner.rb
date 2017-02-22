module Bank
  class Owner
    attr_reader :name, :address, :email

    def initialize(owner_hash)
      @owner_hash = owner_hash
      @name = validate_owner_info(:name)
      @address = validate_owner_info(:address)
      @email = validate_owner_info(:email)
    end

    # makes sure required fields are not nil or empty strings
    def validate_owner_info(required_field)
      if !@owner_hash.has_key?(required_field) || @owner_hash[required_field] == ""
        raise ArgumentError.new "#{required_field} is a required field."
      else
        return @owner_hash[required_field]
      end
    end

  end
end
