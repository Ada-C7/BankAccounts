
require_relative '../lib/account'

module  Bank

  class SavingsAccount < Account
    def initialize(id, start_balance, date = nil)
      super(id, start_balance)
      if start_balance < 10.0
        raise ArgumentError, 'You need at least $10 to open the account'
      end
    end

    def withdraw(amount)
      fee = 2.0
      if @balance - amount < 10.0 || @balance - fee < 10.0 || @balance - amount - fee < 10.0
        puts "Your savings account will be overdrawn!"
        return @balance
      end
      @balance = @balance - amount - fee
      return @balance
    end

    def add_interest(rate)
      # rate = rate.to_f/100
      if rate == nil || rate < 0
        puts "Rate cannot be negative."
      end
      interest = @balance * (rate.to_f/100)
      @balance = @balance + interest
      return interest
    end
  end

end
