module Bank
  class MoneyMarketAccount < Account

    attr_reader :balance, :transaction_count
    MINIMUM_BALANCE = 10000
    TRANSACTION_MAXIMUM = 6

    def initialize(account_info)
      super

      raise ArgumentError.new("Minimum balance is $10,000.") if @balance < MINIMUM_BALANCE
      @transaction_count = 0
    end

    def withdraw(amount)
      if @transaction_count >= 6
        raise ArgumentError.new("Exceeded 6 transaction maximum for current month.")
      end

      if @balance < MINIMUM_BALANCE
        raise ArgumentError.new("Account balance is below $10,000 minimum.")
      end

      @balance -= 100 if amount > @balance - MINIMUM_BALANCE

      super
      @transaction_count += 1
    end

    def deposit(amount)
      if @transaction_count >= TRANSACTION_MAXIMUM && !(@balance < MINIMUM_BALANCE)
        raise ArgumentError.new("Exceeded 6 transaction maximum for current month.")
      end

      super
      @transaction_count += 1
    end

    def add_interest(rate)
      raise ArgumentError.new("Interest rate must be positive.") if rate < 0
      interest = @balance * rate/100
      @balance += interest

      interest
    end

    def reset_transactions
      @transaction_count = 0
    end

  end
end
