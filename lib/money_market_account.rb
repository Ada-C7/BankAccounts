require_relative 'account'

module Bank
  class MoneyMarketAccount  < Bank::Account
    def initialize(id, balance, date)

      #interpreting 1000000 as $10,000.00 because of how the csv file defined balance
      raise ArgumentError.new "Balance must be at least 1000000" if balance < 1000000

      super(id, balance, date)
      @num_transactions = 0
    end

    def withdraw(amount)
      if @num_transactions >= 6
        puts "You have reached the maximum number of transactions for this month."
        return @balance
      end

      if @balance < 1000000
        puts "Your cannot make withdrawals when your balance is below 1000000."
        return @balance
      end

      if (@balance - amount - 10000) < 0
        puts "You can't withdraw that much"
        return @balance
      end

      super(amount)

      @balance -= 10000 if (@balance < 1000000)
      @num_transactions += 1

      return @balance
    end

    def deposit(amount)
      if @num_transactions >= 6
        puts "You have reached the maximum number of transactions for this month."
        return @balance
      end

      super(amount)

      #only adds a transaction if deposit didn't bring balance to >= 1000000
      @num_transactions += 1 if !((@balance - amount) < 1000000)
    end

    def add_interest(rate)
      raise ArgumentError.new "Rate must be positive" if rate <= 0
      interest = @balance * (rate / 100)
      @balance += interest
      return interest
    end
  end
end
