module Bank

  class CheckingAccount < Account

    def initialize(id, balance, opendate = nil)

      super
      @check_withdrawals = 0

    end

    def withdraw(withdrawal_amount)

      original_balance = balance

      super

      if balance == original_balance
        balance
      elsif balance - 1 < 0
        puts "This withdrawal and fee will take your balance below 0."
        @balance = original_balance
      else
        @balance -= 1
      end

    end

    def withdraw_using_check(withdrawal_amount)

      withdraw_positive(withdrawal_amount)

      if @balance - withdrawal_amount < -10
        puts "You can only go negative up to -$10"
        return balance
      end

      @check_withdrawals += 1

      if @check_withdrawals <= 3
        @balance -= withdrawal_amount
      else
        @balance = (@balance - withdrawal_amount - 2)
      end

    end

    def reset_checks
      @check_withdrawals = 0
    end

  end

end
