#require_relative 'account'

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
        print "You're withdrawing too much."
        return @balance
      else
        @balance -= withdrawal_amount + fee
      end
    end

    def withdraw_using_check(withdrawal_amount)
      fee = 2.0

      if withdrawal_amount < 0
        raise ArgumentError
      elsif @balance - withdrawal_amount < -10.0
        print "You are withdrawing too much!"
        return @balance
      elsif @used_checks += 1
       @balance -= fee if @used_checks > 3
       @balance -= withdrawal_amount
      end

    end

    def reset_checks
      @used_checks = 0
    end

  end
end
