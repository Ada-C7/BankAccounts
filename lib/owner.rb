require 'csv'

module Bank
  class Owner
    attr_reader :id, :first_name, :last_name, :street_address, :city, :state

    def initialize(personal_info)
      raise ArgumentError.new("Error: Each user must have an ID.") if personal_info[:id].nil?

      @id = personal_info[:id].to_i
      @last_name = personal_info[:last_name]
      @first_name = personal_info[:first_name]
      @street_address = personal_info[:street_address]
      @city = personal_info[:city]
      @state = personal_info[:state]
    end

    def self.all
      CSV.read("support/owners.csv").collect do |line|
        Owner.new(
          id: line[0].to_i,
          last_name: line[1],
          first_name: line[2],
          street_address: line[3],
          city: line[4],
          state: line[5]
        )
      end
    end

    def self.find(id)
      target = Owner.all.select { |owner| owner.id == id }[0]

      raise ArgumentError.new("Invalid Owner ID.") if target.nil?
      target
    end

  end
end
