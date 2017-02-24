require_relative 'account'

module Bank
  class SavingsAccount < Bank::Account
    def initialize(id, balance)
      raise ArgumentError.new("Starting balance must be at least $10") if balance < 10
      super
    end

    def withdraw(amount)
      @withdrawal_fee = 2
      @balance_limit = 10
      super
    end

    def add_interest(rate)
      raise ArgumentError.new("Rate must be a positive value") if rate < 0

      interest = @balance * (rate/100)
      @balance = @balance + interest
      return interest
      
    end
  end
end
