require_relative 'account'

module Bank

  class MoneyMarketAccount < Account
    attr_accessor :transactions

    def initialize(id, balance)
        raise ArgumentError.new "Money Market Accounts must
        have at least $10,000" if balance < 10000
        super(id, balance)
        @transactions = 6
      end

      def withdraw(amount)
        if balance - amount < 10000
          amount += 100
          @balance -= amount
        end
      end

    end

  end
