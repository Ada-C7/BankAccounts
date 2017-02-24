module Bank
  class CheckingAccount < Account
    def initialize(id, balance, date)
      super(id, balance, date)
      @@withdrawals_by_check = 0
    end

    def withdraw(amount, fee = 100, min_balance = 0)
      super(amount, fee, min_balance)
      return @balance
    end

    def withdraw_using_check(amount)
      balance_before_withdrawal = @balance

      if @@withdrawals_by_check > 2
        self.withdraw(amount, fee = 200, min_balance = -1000 )
      else
        self.withdraw(amount, fee = 0, min_balance = -1000 )
      end

      if @balance < balance_before_withdrawal
        @@withdrawals_by_check += 1
      end
      @balance =  balance
    end

    def reset_checks
      @@withdrawals_by_check = 0
    end
  end
end
