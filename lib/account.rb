require 'csv'

module Bank
  class Account
    attr_reader :id, :balance, :date
    def initialize(id, balance, date) # date = "Jan 1st 2010"
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      @id = id
      @balance = balance
    end


    def withdraw(amount)
      raise ArgumentError.new("Withdrawal amount must be positive.") if amount < 0
      if amount <= @balance
        @balance -= amount
      elsif amount > @balance
        print "Withdrawal denied. The balance in your account would go negative."
      end
      return @balance
    end

    def self.all
      all_accounts = []
      CSV.open("support/accounts.csv").each do |array|
          all_accounts << self.new(array[0].to_i, array[1].to_f, array[2].to_s)
      end
      return all_accounts
    end

    def self.find(id)
      result = self.all.select { |a| a.id == id }
      raise ArgumentError.new("That account does not exist.") if result.length == 0
      if result.length == 0
        return nil
      else
        return result[0]
      end
    end


    def deposit(amount)
      raise ArgumentError.new("Deposit amount must be positive.") if amount < 0
      if amount > 0
        @balance += amount
      end
      return @balance
    end
  end
end
