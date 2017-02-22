module Bank
  class Owner
    attr_reader :name, :address, :email

    def initialize(owner_hash)
      @name = owner_hash[:name]
      @address = owner_hash[:address]
      @email = owner_hash[:email]
    end
  end
end
