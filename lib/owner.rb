module Bank
  class Owner
    def initialize owner_hash
      @first_name = owner_hash[:first_name]
      @last_name = owner_hase[:last_name]
      @address = owner_hash[:address]
      @phone_number = owner_hash[:phone]
    end
  end
end
