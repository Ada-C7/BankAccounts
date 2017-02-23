module Bank
  class Owner
    attr_reader :id, :first_name, :last_name

    def initialize(personal_info)
      @id = personal_info[:id]
      @last_name = personal_info[:last_name]
      @first_name = personal_info[:first_name]
      @street_address = personal_info[:street_address]
      @city = personal_info[:city]
      @state = personal_info[:state]
    end

  end
end
