module Bank

  class CheckingAccount < Account

    def withdraw(withdrawal_amount)
      original_balance = @balance
      super(withdrawal_amount)

      if @balance == original_balance
        @balance
      else
        @balance -= 1
      end

    end

  end

end
