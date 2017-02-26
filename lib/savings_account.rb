require_relative './account'
require 'csv'

module Bank
  class SavingsAccount < Bank::Account
    def initialize(id, balance)
      super(id, balance)
      raise ArgumentError.new("balance must be > 10") if balance < 10
    end

    def withdraw(amount)
      amount += 2

      if (@balance - amount) < 10
        return @balance
        raise ArgumentError.new("account must be > 10") if (@balance - amount) < 10
      else
        @balance = @balance - amount
        return @balance
      end
    end

    def add_interest(rate)
      raise ArgumentError.new("interest must be > 0") if rate < 0

      interest = @balance * (rate / 100)

      @balance = @balance + interest
      return interest
    end

  end
end

# test_1 = Bank::SavingsAccount.new(666, 10_000)
# puts test_1.withdraw(2)
# puts test_1.add_interest(0.25)
