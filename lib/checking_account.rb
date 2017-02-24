module Bank

  class CheckingAccount < Account
    @@check_withdrawals = 0

    def withdraw(withdrawal_amount)

      original_balance = @balance
      puts original_balance
      super

      if @balance == original_balance
        @balance
      elsif @balance - 1 < 0
        puts "This withdrawal and fee will take your balance 0."
        return @balance = original_balance
      else
        @balance -= 1
      end
    end

    def withdraw_using_check(withdrawal_amount)
      raise ArgumentError.new("Withdrawal must be >=0") if withdrawal_amount < 0

      if @balance - withdrawal_amount < -10
        puts "You can only go negative up to -$10"
        return @balance
      else
        #THIS IS FUCKED UP!
        @@check_withdrawals += 1
        if @@check_withdrawals > 3
          return @balance -= 2
        else
          return @balance -= withdrawal_amount
        end
      end

    end

  end

end
