module Bank
  class Owner
    attr_reader :first_name, :last_name, :address, :phone_number

    def initialize owner_hash
      @first_name = owner_hash[:in_first_name]
      @last_name = owner_hash[:in_last_name]
      @address = owner_hash[:in_address]
      @phone_number = owner_hash[:in_phone]
    end
  end
end
