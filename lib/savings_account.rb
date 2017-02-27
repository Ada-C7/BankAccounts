require_relative 'account'

module Bank
  class SavingsAccount < Account
    attr_reader :interest
    def initialize(id, balance, open_date = "1999-03-27 11:30:09 -0800")
      super(id, balance, open_date)
      raise ArgumentError.new("balance must be >= 10") if balance < 10
    end

    def withdraw(amount)
      if @balance - amount - 2 < 10.0
        raise ArgumentError.new("Withdrawal amount requested will bring balance below $10.00")
      end
      @balance = super(amount + 2)
      return @balance
    end

    def add_interest(rate)
      if rate < 0
        raise ArgumentError.new("Interest rate cannot be negative value.")
      end
      interest = @balance * rate / 100
      @balance += interest
      return interest
    end
  end
end
