# Janice Lichtman's Bank Accounts - Wave 1 Optionals

module Bank
  class Owner
    attr_reader :name, :address, :birthday, :pets_name

    def initialize(owner_hash)
      @name = owner_hash[:name]
      @address = owner_hash[:address]
      @birthday = owner_hash[:birthday]
      @pets_name = owner_hash[:pets_name]
    end
  end

end

#janice = Bank::Owner.new(name:"Janice Lichtman", address:"512A N 46th St, Seattle, WA", birthday:"May 16, 1974", pets_name: "Marshmallo")

# puts janice.name
# puts janice.address
# puts janice.birthday
# puts janice.pets_name
