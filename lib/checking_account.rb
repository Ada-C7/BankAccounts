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
        @balance -= amount
        return @balance
      end

      def reset_checks
      end

  end




end
