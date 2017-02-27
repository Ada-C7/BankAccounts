module Bank
  class SavingsAccount < Account

    def initialize(id, balance, date = nil )
      super(id, balance, date)
      #ensures initialize balance is greater than $10
      raise ArgumentError.new("the balance must be >= 10") if balance < 10
    end

    def withdraw(amount)
      super(amount)

      # verifies that balance (after withdrawal and transaction fee) would be >= $10
      if (@balance - 2) >= 10
        return @balance -= 2  # Apply withdrawal fee
      else
        puts "Sorry, your account balance cannot be less than $10."
        return @balance += amount
      end
    end

    # Verifies that interest rate is positive
    # calculates and returns interest accrued
    # updates balance to include accrued interest
    def add_interest(rate)
      raise ArgumentError.new("Interest rate must be > 0") if rate < 0

      interest = @balance * (rate/100)
      @balance = @balance + interest
      return interest
    end

  end
end
