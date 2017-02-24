module Bank
  class Owner

    def initialize(owner_hash)
      @name = owner_hash[:name]
      @address = owner_hash[:address]
      @account_number = owner_hash[:account_number]
    end
  end
end
