module Bank
  class SavingsAccount < Account
    def initialize(id, start_balance)
      super(id, start_balance)

      if start_balance >= 10.0
        @balance = start_balance
      else raise ArgumentError.new
      end
    end

    def withdraw(withdrawal_amount)
      # Does not allow the account to go below the $10 minimum balance
      # Will output a warning message
      # return the original un-modified balan.0ce
      fee = 2.0
      if @balance - (withdrawal_amount + fee) < 10
        print "Balance cannot be under $10"
        return @balance
      else
        @balance -= withdrawal_amount + fee
      end

    end

    def add_interest(rate)
      if rate < 0
        raise ArgumentError
      else
        interest = @balance * rate/100
        @balance += interest
        return interest
      end
    end


  end
end
