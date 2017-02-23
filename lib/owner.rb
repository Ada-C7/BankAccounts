module Bank

  #Class for the owner of an account. Has name, address and phone number
  class Owner
    def self.all
      owner_array = []
      CSV.open("support/owners.csv", 'r').each do |owner|
        id = owner[0]
        name = "#{owner[1]} #{owner[2]}"
        address = "#{owner[3]} #{owner[4]}, #{owner[5]}"
        new_owner = Owner.new(id, name, address)
        owner_array << new_owner
      end
      return owner_array
    end

    def self.find(id)
      CSV.open("support/accounts.csv", 'r').each do |account|
        if account[0] == id
          balance = Integer(account[1])
          open_date = account[2]
          existing_account = Account.new(id, balance, open_date)
          return existing_account
        end
      end
      raise ArgumentError.new "The ID is not associated with an account"
    end
    attr_reader :name, :address, :phone, :id


    def initialize(id, name, address)
      @id = id
      @name = name
      @address = address
    end
  end

end
