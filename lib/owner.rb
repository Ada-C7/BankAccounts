module Bank

  class Owner
    attr_reader :name, :address, :phone

    def initialize(name, address, phone)
      @name = name
      @address = address
      @phone = phone
    end
  end

end
