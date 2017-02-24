
module Bank
  class SavingsAccount < Account
    def initialize(id, balance, date)

      raise ArgumentError.new("balance must be at least $10") if balance < 1000

      super(id, balance, date)
    end

    def withdraw(amount)
      fee = 200
      min_balance = 1000
      super(amount, fee, min_balance)
    end

    def add_interest(rate)
      raise ArgumentError.new("Negative interest rates are not only bad for your finances; they are illegal") if rate < 0

      interest = @balance * rate/100
      @balance += interest
      return interest
    end
  end
end
