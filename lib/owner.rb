module Bank
  class Owner
    attr_reader :customer_id, :first_name, :last_name, :street, :city, :zipcode, :address, :phone
    def initialize owner_hash
      # assumes that owner_hash structure is
      # {customer_id:
      name: "ginny smith", address => {street: "122 main st.", city: "seattle", zipcode: "98144"}, phone: "2065573099" }
      # if owner_hash.class != Hash
      #   raise ArgumentError.new "Erroneous argument used for the constructor"
      # else
      @name = owner_hash[:name]
      # @street = owner_hash[:address][:street]
      # @city = owner_hash[:address][:city]
      # @zipcode = owner_hash[:address][:zipcode]
      # @address = { street: @street, city: @city, zipcode: @zipcode }
      @address = owner_hash[:address]
      @phone = owner_hash[:phone]
      #end
    end
  end
end
