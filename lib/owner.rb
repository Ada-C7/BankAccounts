require 'csv'
module Bank

  class Owner
    attr_reader :last_name, :first_name, :street_address, :city, :state, :id

    def initialize(owner_info)
      @id = owner_info[:id]
      @last_name = owner_info[:last_name]
      @first_name = owner_info[:first_name]
      @street_address = owner_info[:street]
      @city = owner_info[:city]
      @state = owner_info[:state]
    end

    # this method takes in a file and returns a list of owner objects
    def self.all(csv_file)
      @owners = CSV.read(csv_file)
      @owners.map! do |owner_info|
        owner_hash = Hash.new
        owner_hash[:id] = owner_info[0].to_i
        owner_hash[:last_name] = owner_info[1]
        owner_hash[:first_name] = owner_info[2]
        owner_hash[:street] = owner_info[3]
        owner_hash[:city] = owner_info[4]
        owner_hash[:state] = owner_info[5]
        owner_info = owner_hash
      end
      # print @owners
      @owners.map! { |owner_hash| self.new(owner_hash) }
      # puts @owners
      return @owners
    end

    def self.find(id)
      @owners.each do |owner|
        return owner if owner.id == id
      end
    end

  end
end

# Bank::Owner.all('../support/@@owners.csv')


# puts person_info[:stupid_id]
#
# account_owner = Bank::Owner.new(person_info)
#
# puts account_owner.last_name
# puts account_owner.first_name
# puts account_owner.street
# print account_owner.id_number
