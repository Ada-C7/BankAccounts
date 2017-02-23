require 'csv'

module Bank
  class Account
    attr_reader :id, :balance, :date
    def initialize(id, balance, date)
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
      @date = date
    end

    def withdraw(amount)
      raise ArgumentError.new("withdrawal amount must be >= 0") if amount < 0

      if amount <= @balance
        return @balance -= amount
      elsif amount > @balance
        puts "Sorry, you don't have that much money."
        return @balance
      end
    end

    def deposit(amount)
      raise ArgumentError.new("deposit amount must be >= 0") if amount < 0
      @balance += amount
    end

    def self.all
      accounts = []
      CSV.open("./support/accounts.csv").each do |line|
        accounts << Account.new(line[0].to_i, line[1].to_i, line[2])
      end
      return accounts
    end

    def self.find(id)
      all.each do |account|
        if account.id == id
          return account
        end
      end
      raise ArgumentError.new("that account does not exist")
    end

  end
end
