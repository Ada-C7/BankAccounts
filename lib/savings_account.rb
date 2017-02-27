module Bank

  class SavingsAccount < Account

    include Interest

    def initialize(id, balance, opendate = nil)
      super

      if @balance < 10
        argument("You must initially deposit at least $10.00")
      end
    end

    def withdraw(withdrawal_amount)
      original_balance = balance
      super

      if balance == original_balance
        balance
      elsif balance - 2 <= 10
        puts "This withdrawal and fee will take your balance below $10."
        @balance = original_balance
      else
        withdrawal_fee
      end
    end

    def withdrawal_fee
      @balance -= 2
    end

  end

end
