# Update the Account class to be able to handle all of these fields from the CSV file used as input.
# For example, manually choose the data from the first line of the CSV file and ensure you can create a new instance of your Account using that data

require 'csv'


module Bank
  class Account
    attr_accessor :id, :balance, :date_created
    def initialize(id, balance, date_created = nil)
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      @id = id
      @balance = balance
      @date_created = date_created

    end

    def self.all
      @accounts = []
      CSV.open("./support/accounts.csv").each do |line|
        @accounts << self.new(line[0].to_i, line[1].to_f, line[2].to_s)
      end
        return @accounts
    end

    def self.find(id)
      account_find = Bank::Account.all
      account_find.each do |account|
        if account.id == id
          return account
        end
      end
      raise ArgumentError.new "Account #{id} doesn't exist, sorry"
    end

    def withdraw(amount)
      raise ArgumentError.new("amount must be >= 0") if amount < 0
      if @balance - amount < 0
        puts "Balance cannot be negative"
        return @balance
      else
        return @balance -= amount
      end
    end

    def deposit(amount)
      raise ArgumentError.new("amount must be >= 0") if amount < 0
      return @balance += amount
    end
  end
end
