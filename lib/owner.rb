module Bank
  class Owner
    attr_reader :name
    
    def initialize(personal_info)
      @name = personal_info[:name]
      @address = personal_info[:address]
      @phone_number = personal_info[:phone_number]
      @accounts = personal_info[:accounts]
    end

  end
end
