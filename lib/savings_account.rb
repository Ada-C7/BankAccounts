module Bank
  class SavingsAccount < Account

    def initialize(id, start_balance)
      super(id, start_balance)

      if start_balance >= 10.0
        @balance = start_balance
      else
        raise ArgumentError.new "New balance must be equal or greater than 10"
      end

    end

    def withdraw(withdrawal_amount)
      fee = 2.0

      if @balance - (withdrawal_amount + fee) < 10
        print "Balance cannot be under $10"
        return @balance
      else
        # @balance -= withdrawal_amount + fee
        super(withdrawal_amount)
        super(fee)
      end

    end

    def add_interest(rate)
      if rate < 0
        raise ArgumentError.new "Interest rate must be positive"
      else
        interest = @balance * rate/100
        @balance += interest
        return interest
      end
    end

  end
end
