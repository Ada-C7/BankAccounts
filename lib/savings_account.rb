require_relative 'account'

module Bank
  class SavingsAccount < Account
    def initialize(id, balance)
      #ignoring the early mention that balance was in cents
      raise ArgumentError.new("Balance must be atleast $10") if balance < 10
      super(id, balance)
    end

    def withdraw(amount)
      start_balance = @balance
      withdrawal_amount = amount
      fee = 2
      if withdrawal_amount < 0
        raise ArgumentError.new 'You cannot withdraw a negative number'
      end
      if withdrawal_amount > (@balance-10)
        puts 'Warning, account would go below $10. Cannot withdraw.'
        withdrawal_amount = 0
        fee = 0
      end
      if withdrawal_amount + fee > (@balance-10)
        puts 'Warning, account would go below $10. Cannot withdraw.'
        withdrawal_amount = 0
        fee = 0
      end
      new_balance = start_balance - withdrawal_amount - fee
      @balance = new_balance
    end

    def add_interest(rate)
      if rate < 0
        raise ArgumentError.new 'Interest rate cannot be a negative number'
      end
      interest = @balance * rate / 100
      @balance += interest
      return interest
    end
  end
end
