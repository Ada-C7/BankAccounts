require 'csv'
# require 'awesome_print'

module Bank
  class Account
    attr_reader :id, :balance, :open_date
    def initialize(id, balance, open_date = "")
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
      @open_date = open_date
    end

    def withdraw(amount)
      raise ArgumentError.new("withdrawl must be >= 0") if amount < 0
      @balance -= amount
      return @balance if @balance >= 0
      puts "Requested withdrawl amount surpasses account balance."
      @balance += amount
    end

    def deposit(amount)
      raise ArgumentError.new("deposit must be >= 0") if amount < 0
      @balance += amount
    end

    def self.all
      accounts = []
      CSV.open("support/accounts.csv").each do |line| # direct path or relative path?
        accounts << self.new(line[0].to_i, line[1].to_i, line[2])
      end
      return accounts
    end

    #better to make @@accounts vs. read file again?
    def self.find(id)
      CSV.open("support/accounts.csv").each do |line|
        if line.first.to_i == id
          return self.new(line[0].to_i, line[1].to_i, line[2])
        end
      end
      raise ArgumentError.new("ID does not exist")
    end
  end
end
#
# accounts = []
# CSV.open("../support/accounts.csv").each do |line|
#   accounts << Bank::Account.new(line[0].to_i, line[1].to_i, line[2])
# end
#
# ap accounts
