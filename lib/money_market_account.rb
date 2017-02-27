require 'csv'
require 'date'
require_relative 'account'

module Bank

  class MoneyMarketAccount < Account


    def initialize(id, balance, open_date='2010-12-21 12:21:12 -0800')
      super(id, balance, open_date)
      raise ArgumentError.new("balance must be >= 10,000") if balance < 10000
      @transactions_used = 0
      @transactions_allowed = true
    end

    def transaction_count
      @transactions_used
    end

    def reset_transactions
      @transactions_used = 0
    end

    def withdraw(withdrawal_amount)
      if @transactions_allowed

        if @transactions_used < 6
          @transactions_used += 1
          super(withdrawal_amount)
          if @balance < 10000
            @balance -= 100
            @transactions_allowed = false
            puts "Your account is now too low. You must make a deposit to allow more transactions."
            return @balance
          end
        else
          puts "You have already used all your transactions this month."
          @balance
        end
      else
        puts "Withdrawal not allowed. Account balance is too low. You must make a deposit to re-enable transactions. "
        return @balance
      end
    end

    def deposit(deposit_amount)
      if !(@transactions_allowed)
        @transactions_allowed = true
        super(deposit_amount)
      else
        if @transactions_used < 6
          @transactions_used += 1
          super(deposit_amount)
        else puts "You have already used all your transactions this month."
          @balance
        end
      end
    end

    def add_interest(rate)
      raise ArgumentError.new("Interest rate must be > 0") if rate <= 0
      interest = @balance * (rate/100)
      @balance += interest
      return interest
    end

  end
end
