require_relative 'account'
module Bank
  class SavingsAccount < Bank::Account
    attr_reader :id, :balance

    def initialize(id, balance = 10)
      raise ArgumentError.new("balance must be >= 10") if balance < 10

      @id = id
      @balance = balance
    end

    def withdraw(amount)
      new_balance = @balance - (amount+2)
      if new_balance < 10
        puts "Warning: insufficient fund."
        return @balance
      end
      @balance = new_balance
    end

    def add_interest(rate)
      raise ArgumentError.new("rate must be >= 0") if rate < 0
      interest = @balance * rate/100
      @balance = @balance + interest
      return interest
    end
  end
end
