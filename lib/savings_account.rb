
require_relative '../lib/account'

module  Bank
  class SavingsAccount < Account

    def initialize(id, initial_balance, date= nil)
      super(id, initial_balance, date= nil)
      if initial_balance < 10.0
        raise ArgumentError, 'You need at least $10 to open the account'
      end

      def withdraw(amount)
        fee = 2.0
        if @balance - amount - fee < 10.0
          puts "Your balance will be overdrawn!"
          return @balance
        end
        @balance = @balance - amount - fee
        return @balance
      end

      def add_interest(rate)
      end
    end
  end
end
