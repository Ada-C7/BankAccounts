require_relative 'account'

module Bank

  class MoneyMarketAccount < Bank::Account
    attr_reader :total_transactions

    def initialize(id, balance, opendate = nil)
      super
      @total_transactions = 0
    end

    def set_balance(start_balance)
      # IF the initial balance is < 10,000
      #raise an argument error.
      if start_balance < 10000
        raise ArgumentError.new "You cannot initialize a new Money Market account with less than 10k."
      else
        start_balance
      end
    end

    def withdraw(withdrawal_amount)
      @total_transactions += 1

      if @total_transactions > 6
        raise ArgumentError.new "You cannot make more than six transactions per month."
      end

      if @balance < 10000
        raise ArgumentError.new "You cannot make another withdrawal until you make a deposit"
      end

      super

      if @balance < 10000
        @balance -= 100
      end

    end

    def deposit(deposit_amount)

      if @balance > 10000
        @total_transactions += 1
      end

      if @total_transactions > 6
        raise ArgumentError.new "You cannot make more than six transactions per month."
      end

      super

    end

    def reset_transactions
      @total_transactions = 0
    end

  end

end
