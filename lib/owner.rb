module Bank
  class Owner
    attr_reader :id
    attr_accessor :last_name, :first_name, :street_address, :city, :state
    def initialize owner_hash = {}
    # assumes that the parameter value is either properly formatted hash or an empty hash

      if owner_hash != {}
        [:id, :last_name, :first_name, :street_address, :city, :state].each do |expected_key|
          if !owner_hash.has_key?(expected_key)
            raise ArgumentError.new "Hey you are missing #{expected_key} information for the owner!"
          end
        end

        @id = owner_hash[:id]
        @first_name = owner_hash[:first_name]
        @last_name = owner_hash[:last_name]
        @street_address = owner_hash[:street_address]
        @city = owner_hash[:city]
        @state = owner_hash[:state]
      else
        @id = 0
      end
    end

    # method that returns a collection of Owner instances, from data read in CSV
    def self.all
      all_owners_array= []

      CSV.read("support/owners.csv").each do |line|
        all_owners_array << Bank::Owner.new(
          {
            id: line[0].to_i,
            last_name: line[1],
            first_name: line[2],
            street_address: line[3],
            city: line[4],
            state: line[5]
          }
        )
      end

      return all_owners_array
    end

    # method that returns an instance of an Owner where the value of the id field
    # in the CSV matches the passed parameter
    def self.find(id)
      raise ArgumentError.new ("Account id must be an positive integer value") if ( id.class != Integer || id < 1 )

      CSV.read("support/owners.csv").each do |line|
        if line[0].to_i == id
          owner = Bank::Owner.new(
            {
              id: line[0].to_i,
              last_name: line[1],
              first_name: line[2],
              street_address: line[3],
              city: line[4],
              state: line[5]
            }
          )
          return owner
        end
      end
      raise ArgumentError.new "Owner id does not exist in the database"
    end

  end
end
