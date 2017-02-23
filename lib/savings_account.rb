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
        @balance = super(amount) - 2
        return @balance
      end
  end




end
