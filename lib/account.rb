require 'csv'

module Bank
  class Account
    attr_reader :id, :balance, :date_created
    @@Accounts = []
    def initialize(id, balance, date_created)
      @id = id
      @balance = balance
      @date_created = date_created
      @@Accounts << [id, balance, date_created]
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
      return @@Accounts
    end

    def self.find(id)
      @@Accounts.each do |account|
        if account[0] == id
          return account
        else
          raise ArgumentError.new("that account cannot be found")
        end
      end
    end

    def self.create_many_accounts
      many_accounts = []
      CSV.open("./support/accounts.csv").each do |line|
          many_accounts << self.new(line[0].to_i, line[1].to_i, line[2])
      end
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
