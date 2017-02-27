require_relative 'account'

module Bank
  class SavingsAccount < Account
    def initialize(id, balance)
      # Account must have a minimum balance of $10
      raise ArgumentError.new("balance must be >= 10") if balance < 10
      super(id, balance)
    end

    def withdraw(amount)
      fee = 2.0
      balance_min = 10.0
      withdraw_internal(amount + fee, balance_min)
    end

    def add_interest(rate) #input rate is assumed a percentage
      raise ArgumentError.new("interest rate must be positive") if rate <= 0
      interest = @balance * rate / 100
      @balance +=interest
      return interest
    end
  end
end
