require_relative 'account'

module Bank
  class CheckingAccount < Bank::Account

    def initialize(id, balance, date)
      super(id, balance, date)
      @monthly_checks_used = 0
    end

    def withdraw(withdrawal_amount)
      if (@balance - withdrawal_amount - 100) < 0
        puts "You can't withdraw that much"
        return @balance
      end

      super(withdrawal_amount)

      return @balance -= 100 #interpreting 100 as $1.00
    end

    def withdraw_using_check(amount)
      raise ArgumentError.new "You cannot withdraw a negative amount." if amount <= 0

      if @monthly_checks_used >= 3
        fee = 200
      else
        fee = 0
      end

      if (@balance - amount - fee) < -1000
        puts "You cannot withdraw that much"
        return @balance
      end

      @monthly_checks_used += 1
      return @balance -= (amount + fee)
    end

    def reset_checks
      @monthly_checks_used = 0
    end
  end
end
