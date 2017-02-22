module Bank

  #Class for the owner of an account. Has name, address and phone number 
  class Owner
    attr_reader :name, :address, :phone

    def initialize(name, address, phone)
      @name = name
      @address = address
      @phone = phone
    end
  end

end
