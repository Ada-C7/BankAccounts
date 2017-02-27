require_relative 'account'

module Bank
  class SavingsAccount < Account

    def initialize(id, balance)
      super(id, balance, nil, 2)

      if balance < 10
        raise ArgumentError.new "Starting balance is too low, please enter an amount greater than $10."
      end
    end

    def withdraw(amt)
      if balance - amt - withdrawal_fee < 10
        puts "Amount too large, please enter a smaller amount."
        return balance
      end
      return super(amt)
    end

    def add_interest(rate)
      if rate > 0
        interest_earned = (balance) * (rate.to_f / 100)
        @balance = interest_earned + @balance
        return interest_earned.to_f
      else
        raise ArgumentError.new "Error. Please enter a positive rate."
      end
    end
  end
end
