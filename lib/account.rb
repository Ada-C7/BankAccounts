require 'csv'
#require_relative '../support'

module Bank
  class Account
    attr_reader :id, :balance, :owner

    def initialize(id, balance = 0)
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
    end

    def self.all
      accounts = []
      CSV.read("support/accounts.csv").each do |line|
        accounts << Account.new(line[0], line[1].to_i)
      end
      return accounts
    end

    def self.find
      @id = Account.new([:id])
    end


    def withdraw(amount)
      raise ArgumentError.new("amount must be >= 0") if amount < 0
      if amount > @balance
        puts "Warning: insufficient fund."
      else
        @balance = @balance - amount
      end
      return @balance
    end
    def deposit(amount)
      raise ArgumentError.new("amount must be >= 0") if amount < 0
      @balance = @balance + amount
      return @balance
      # @balance += amount
    end
    def add_owner (owner)
      @owner = owner
    end
  end

  class Owner
    attr_reader :name, :address
    def initialize(name, address)
      @name = name
      @address = address
    end
  end
end
