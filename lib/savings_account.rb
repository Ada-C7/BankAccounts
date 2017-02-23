require_relative 'account'

module Bank


  class SavingsAccount < Account

      def initialize(id, balance, open_date=nil)
        raise ArgumentError.new "The balance must be at least $10" if balance < 10
        super(id, balance)
      end

      def withdraw(amount)
        if (@balance - amount) < 10
          print "Warning! This will cause your balance to go below $10"
          return @balance
        end
        super(amount)
        if @balance - 2 < 10
          print "Warning! This will cause your balance to go below $10"
          @balance += amount
        else
        @balance -= 2
        end

        return @balance
      end
  end




end
