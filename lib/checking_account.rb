module Bank

  class CheckingAccount < Account

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

  end

end
