require_relative 'account'

module Bank
  class CheckingAccount < Account
    attr_reader :check_count
    def initialize(id, balance, date)
      super(id, balance, date)
      raise ArgumentError.new("balance must be >= -10.0") if balance <= 10.1
      @check_count = 0
    end

    def withdraw(amount)
      amount += 1
      super(amount)
    end

    def withdraw_using_check(amount)
      if (@check_count < 3) && (@balance - amount >= -10)
          @balance -= (amount)
          @check_count += 1
      elsif (@check_count >= 3) && (@balance - amount >= -12)
          @balance -= (amount + 2)
      else
        print "Withdrawal denied. The balance in your account would go negative."
      end
      return @balance
    end

    def reset_checks
      @check_count = 0
    end

  end
end
