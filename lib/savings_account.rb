require_relative 'account'

module Bank
  class SavingsAccount < Account
    def initialize(id, balance)
      super(id, balance)
      raise ArgumentError.new("balance must be >= 10") if balance < 10
    end

    def withdraw(withdraw_amount)
      fee = 2
      raise ArgumentError.new("Unvalid amount!") if withdraw_amount < 0
      if (@balance - (withdraw_amount + fee)) < 10
        print "warning! Your balance is less than 10 after fee applied"
        return @balance
      end

      return @balance if (@balance -= (withdraw_amount + fee)) >= 10
    end

    def add_interest(rate)
      raise ArgumentError.new("rate must be positive") if rate < 0

      interest = @balance * rate
      @balance += interest
    end

  end
end
