module Bank

  class Owner

    attr_reader :name, :address, :account_type

    def initialize(owner_info_hash)
      @name = owner_info_hash[:name]
      @address = owner_info_hash[:address]
      @account_type = owner_info_hash[:account_type]
    end
  end

end


# Create an Owner class which will store information about those who own the Accounts.
# This should have info like name and address and any other identifying information that an account owner would have.
