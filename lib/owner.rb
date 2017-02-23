module Bank
  class Owner
    attr_reader :id, :first_name, :last_name, :street_address

    def initialize(personal_info)
      raise ArgumentError.new("Error: Each user must have an ID.") if personal_info[:id].nil?

      @id = personal_info[:id]
      @last_name = personal_info[:last_name]
      @first_name = personal_info[:first_name]
      @street_address = personal_info[:street_address]
      @city = personal_info[:city]
      @state = personal_info[:state]
    end

    def self.all
      CSV.read("support/owners.csv").collect do |line|
        Owner.new(
          id: line[0],
          last_name: line[1],
          first_name: line[2],
          street_address: line[3],
          city: line[4],
          state: line[5]
        )
      end
    end

  end
end
