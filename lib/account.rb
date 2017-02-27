require 'csv'
require 'time'

module Bank
  class Account
    attr_reader :id, :balance, :date
    def initialize(id, balance, date="nil")
      @id = id
      @balance = balance
      @date = date
      raise ArgumentError.new("balance must be >= 0") if balance < 0
    end

    def self.find(id1)
      @accounts_array.each do |line|
        return line if line.id == id1
        raise ArgumentError.new("no valid id") if line.id != id1
      end
    end

    def self.all
      @accounts_array = []
      #I had to use this whole branch because it was the only way it worked
      #Wierd!
      #A little out the line of good style. Sorry
      CSV.open("/Users/laurams/ada/homework/BankAccounts/support/accounts.csv").each do |line|
        @accounts_array << self.new(line[0].to_i, line[1].to_i, Time.parse(line[2]))
      end
      @accounts_array
    end

    def withdraw(withdraw_amount)
      raise ArgumentError.new("Unvalid amount!") if withdraw_amount < 0
      if (@balance - withdraw_amount) <0
        print "warning! Your balance is #{@balance}"
        return @balance
      end

      return @balance if (@balance -= withdraw_amount) >= 0
    end

    def deposit(amount)
      raise ArgumentError.new("Can't deposit negative money") if amount < 0
      @balance += amount
    end
  end
end
