require_relative 'account'

module Bank


  class CheckingAccount < Account
    attr_accessor :checks

    def initialize(id, balance)
      super(id, balance)
      @checks = 3
    end

    def withdraw(amount)
      super(amount)
      if @balance - 1 < 0
        print "Warning! This will cause your balance to go below $0"
        @balance += amount
      else
        @balance -= 1
      end
      return @balance
    end

    def withdraw_using_check(amount)
      raise ArgumentError.new "The amount withdrawn must be a positive number" if amount < 0
      if @balance - amount < -10
        print "Warning! This will cause your balance to go below $-10"
        return @balance
      end
      if @checks >= 1
        @balance -= amount
        @checks -= 1
        return @balance
      else
        @balance -= amount
        @balance -= 2
        @checks -= 1
        return @balance
      end
    end

    def reset_checks
      @checks = 3
      return @checks
    end

  end

end
