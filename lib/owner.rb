require 'csv'

module Bank
  class Owner
    attr_reader :id, :last_name, :first_name, :address, :city, :state

    def self.all
      owners = []
      CSV.read("support/owners.csv").each do |line|
        owners << Bank::Owner.new( {
          id: line[0].to_i,
          last_name: line[1],
          first_name: line[2],
          address: line[3],
          city: line[4],
          state: line[5]
        } )
      end
      return owners
    end

    def self.find(id)
      owners = Bank::Owner.all
      owners.each do |owner|
        return owner if id == owner.id
      end
      raise ArgumentError.new("Owner does not exist")
    end

    def initialize(owner_hash)
      @owner_hash = owner_hash

      raise ArgumentError.new "ID must be an Integer" if validate_owner_info(:id).class != Integer
      @id = validate_owner_info(:id)
      @last_name = validate_owner_info(:last_name)
      @first_name = validate_owner_info(:first_name)
      @address = validate_owner_info(:address)
      @city = validate_owner_info(:city)
      @state = validate_owner_info(:state)
    end

    # makes sure required fields are not nil or empty strings
    def validate_owner_info(required_field)
      if !@owner_hash.has_key?(required_field) || @owner_hash[required_field] == ""
        raise ArgumentError.new "#{required_field} is a required field."
      else
        return @owner_hash[required_field]
      end
    end

  end
end

# owners = Bank::Owner.all
#
# owners.each do |owner|
#   puts owner.state
#
# end
#
# puts Bank::Owner.find(20).first_name
