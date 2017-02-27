require_relative 'account'

module Bank
  class SavingsAccount < Account
    def initialize(id, balance)
      # Account must have a minimum balance of $10
      raise ArgumentError.new("Balance must be atleast $10") if balance < 10
      super(id, balance)
    end

    def withdraw(amount)
      start_balance = @balance
      withdrawal_amount = amount
      if withdrawal_amount < 0
        raise ArgumentError.new 'You cannot withdraw a negative number'
      end
      if withdrawal_amount > 1000
        puts 'Warning, account would go below $10. Cannot withdraw.'
        withdrawal_amount = 0
      end
      @balance = start_balance - withdrawal_amount - 200
    end

    def add_interest(rate)
      if rate < 0
        raise ArgumentError.new 'Interest rate cannot be a negative number'
      end
      @balance = @balance * (rate/100)
    end
  end
end
