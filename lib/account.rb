require 'csv'

module Bank
  class Account
    attr_reader :id, :balance, :Accounts
    @@Accounts = []
    def initialize(id, balance) # date_created)
      @id = id
      @balance = balance
      # @date_created = date_created
      @@Accounts << [id, balance] # date_created]
      raise ArgumentError.new("balance must be >= 0") if balance < 0
    end

    def withdraw(amount)
        raise ArgumentError.new("amount must be >= 0") if amount < 0
      if @balance - amount < 0
        puts "whoops! you don't have that much money in your account! your balance is #{@balance}."
        return @balance
      else
        return @balance -= amount
      end
    end

    def deposit(amount)
      raise ArgumentError.new("amount must be >= 0") if amount < 0
      return @balance += amount
    end

    def self.all
      @@Accounts
    end

    def self.find(id)
      return_account = []
      @@Accounts.each do |account|
        # this logic was so wrong but then i FIXED IIIIIIT
        if account[0] == id
          return_account = account
        end
      end
      if return_account == []
       raise ArgumentError.new("that account cannot be found")
      else
       return return_account
      end
    end

    def self.create_many_accounts
      many_accounts = []
      CSV.open("./support/accounts.csv").each do |line|
          many_accounts << self.new(line[0].to_i, line[1].to_i)
      end
      return many_accounts
    end

  end

  # class Owner
  #   attr_reader :name, :address
  #   def initialize(name, address)
  #     @name = name
  #     @address = address
  #   end
  # end

end
