module Bank
  # CheckingAccount's responsibility is to maintian the balance of a checking account
  class CheckingAccount < Account
    attr_reader :id, :balance, :checks_used

    def initialize(id, balance, date = '')
      super(id, balance, date = '')
      # need to rename?
      @checks_used = 0
    end

    def withdraw(withdrawal_amount)
      super(withdrawal_amount + 1)
    end

    def above_min_balance?(withdrawal_amount)
       @balance - withdrawal_amount + 10  >= 0
    end

    def withdraw_using_check(withdrawal_amount)
      return "Insufficient Funds" if ( @balance - withdrawal_amount ) <= -10
      @checks_used < 3 ? withdrawal_amount : withdrawal_amount += 2
      withdraw(withdrawal_amount - 11)
      @checks_used += 1
      @balance -=10
    end

    def reset_checks
      @checks_used = 0
    end
  end
end
