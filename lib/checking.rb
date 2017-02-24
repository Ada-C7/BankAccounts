
module Bank

  class CheckingAccount < Account

    def initialize(id, balance, date, owner = "Customer Name")
      super
      @check_count = 0
    end

    def withdraw(withdrawal_amount)
      if (withdrawal_amount + 1) > @balance
        print "You can't overdraw your account."
        return @balance
      else
        @balance -= (withdrawal_amount + 1)
      end
      return @balance
    end

    def withdraw_using_check(withdrawal_amount)
      raise ArgumentError.new("You cannot withdraw a negative amount of money using a check.") if withdrawal_amount < 0

      if @balance < withdrawal_amount - 10
        print "There must always be at least $10 in your savings."
        return @balance
      end

      @check_count += 1
      if @check_count <= 3
        return @balance -= withdrawal_amount
      else
        return @balance -= (withdrawal_amount + 2)
      end
    end

    def reset_checks
      @check_count = 0
    end

  end

end
