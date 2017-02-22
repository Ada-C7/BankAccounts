
module Bank
  class Owner
    attr_reader :name, :address, :phone
    def initialize (name, address, phone)
      @name = name
      @address = address
      @phone = phone
    end
  end
end

# owner = Bank::Owner.new("Natalia", "123 Main st ", "432332322")
# puts owner.address
