module Bank

  class SavingsAccount < Account

    def initialize(id, balance, opendate = nil)

      super

      if @balance < 10
        argument("You must initially deposit at least $10.00")
      end

    end

    def withdraw(withdrawal_amount)

      original_balance = @balance
      super

      if @balance == original_balance
        balance
      elsif @balance - 2 <= 10
        puts "This withdrawal and fee will take your balance below $10."
        return @balance = original_balance
      else
        withdrawal_fee
      end

    end

    def withdrawal_fee
      @balance -= 2
    end

    def add_interest(rate)

      argument("Interest rate must be >= 0") if rate < 0

      interest = @balance * (rate/100)
      @balance += interest

      return interest

    end

  end

end
