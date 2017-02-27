require 'csv'
require 'date'

module Bank
  class Account
    attr_reader :id, :balance, :date_opened

    def initialize(id = "", balance = "", date_opened = "")
      @id = id.to_i
      @balance = balance.to_i
      @date_opened = date_opened

      raise ArgumentError.new("balance must be >= 0") if @balance < 0
      if @balance < 0
        then
        puts "balance must be >= 0"
      end

    end

    def self.all
      array =[]
      CSV.open("../support/accounts.csv").each do |line|
        array << self.new(line[0], line[1], line[2])
      end
      return array
    end

    def self.find(id)
      self.all.each do |account|
        if account.id == id then puts account.id
          return account.id
        end
      end
      raise ArgumentError.new("You must select a valid account")
    end

    def withdraw(amount)
      if amount > 0
        if (@balance - amount) >= 0
          @balance -= amount
        else
          puts "You have insufficient funds"
        end
      else
        puts "You must withraw an amount greater than $0.00 dollars"
        raise ArgumentError.new("you must withdraw an amount greater than $0.00")
      end
      return @balance
    end

    def deposit(amount)
      if amount >= 0
        @balance += amount
      else
        puts "You must deposit an amount greater than $0.00 dollars"
        raise ArgumentError.new("you must deposit an amount greater than $0.00")
      end
      return @balance

    end
  end
end

 Bank::Account.find(122)
