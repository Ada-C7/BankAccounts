module Bank
  class Owner
    attr_reader :id, :last_name, :first_name, :street_address, :city, :state

    def initialize id, last_name, first_name, street_address, city, state
      @id = id
      @last_name = last_name
      @first_name = first_name
      @street_address = street_address
      @city = city
      @state = state
    end

    def self.all
      owners = []

      CSV.read("/Users/sai/Documents/ada/projects/BankAccounts/support/owners.csv").each do |line|
        owners << Owner.new(line[0].to_i, line[1], line[2], line[3], line[4], line[5])
      end
      
      return owners
    end

    def self.find id
      all_owners = Owner.all
      owner_found = false

      all_owners.each do |owner|
        if owner.id == id
          owner_found = true
          return owner
        end
      end

      if !owner_found
        puts "ID not found "
      end

    end

  end
end
