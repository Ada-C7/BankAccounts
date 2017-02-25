require_relative 'account'

module Bank
  class SavingsAccount < Account
    def initialize(id, balance, date)
      super(id, balance, date)
      raise ArgumentError.new("balance must be >= 10.0") if balance < 10.0
    end

    def withdraw(withdrawal_amount)
      raise ArgumentError.new("Withdrawal amount must be positive.") if withdrawal_amount < 0
      if withdrawal_amount <= (@balance - 12)
        @balance -= (withdrawal_amount + 2)
      else
        print "Withdrawal denied. The balance in your account would go negative."
      end
      return @balance
    end

    def add_interest(rate)
      raise ArgumentError.new("Intereste rate must be positive.") if rate < 0
      interest_earned = (@balance * (rate/100))
      @balance += interest_earned
      return interest_earned
    end

  end
end
