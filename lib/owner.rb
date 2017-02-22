module Bank
  class Owner
    attr_reader :customer_id
    attr_accessor :name, :address, :phone
    def initialize owner_hash = {}
      if owner_hash != {}
        # assumes that owner_hash structure is
        # { customer_id: 1024, first_name: "ginny", last_name: "smith", address: {street: "123 main street", city: "seattle", state: "WA", zipcode: "12345"}, phone: "2065573099" }
        @customer_id = owner_hash[:customer_id]
        @name = "#{owner_hash[:first_name]} #{owner_hash[:last_name]}"
        @address = "#{owner_hash[:address][:street]}, #{owner_hash[:address][:city]}, #{owner_hash[:address][:state]} #{owner_hash[:address][:zipcode]}"
        @phone = owner_hash[:phone]
      else
        @customer_id = "0000"
      end
    end
  end
end
