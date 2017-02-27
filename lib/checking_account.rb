module Bank
  class CheckingAccount < Account
    attr_reader :used_checks

    def initialize(id, start_balance)
      super(id, start_balance)

      @used_checks = 0
    end

    def withdraw(withdrawal_amount)
      fee = 1.0

      if @balance - (withdrawal_amount + fee) < 0
        print "You're withdrawing too much"
        return @balance
      else
        # @balance -= withdrawal_amount + fee
        # have to do super for withdrawal amount and fee separately
        # in case the user inputed negative value that's lower than 1
        # because adding one to it would amke it positive
        super(withdrawal_amount)
        super(fee)
      end

    end

    def withdraw_using_check(withdrawal_amount)
      fee = 2.0

      if withdrawal_amount < 0
        raise ArgumentError.new "Withdrawal amount must be positive"
      elsif @balance - withdrawal_amount < -10.0
        print "You are withdrawing too much"
        return @balance
      else
       @used_checks += 1
       @balance -= fee if @used_checks > 3
       @balance -= withdrawal_amount
      end

    end

    def reset_checks
      @used_checks = 0
    end

  end
end
