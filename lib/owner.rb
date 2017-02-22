module Bank

  class Owner
    attr_reader :last_name, :first_name, :phone_number, :street, :city, :zipcode, :state

    def initialize(owner_info)
      @last_name = owner_info[:last_name]
      @first_name = owner_info[:first_name]
      @phone_number = owner_info[:phone_number]
      @street = owner_info[:street]
      @city = owner_info[:city]
      @zipcode = owner_info[:zipcode]
      @state = owner_info[:state]
    end
  end

end
