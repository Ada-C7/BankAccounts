require_relative 'account'

module Bank


  class SavingsAccount < Account


      def initialize(id, balance, open_date=nil)
        raise ArgumentError.new "The balance must be at least $10" if balance < 10
        super(id, balance)
      end

      def withdraw(amount)
        raise ArgumentError.new "This will cause the balance to go below 0" if (@balance - amount) < 10
        super(amount)
        @balance -= 2
      end
  end




end
