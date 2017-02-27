require_relative 'account'

module Bank
  class SavingsAccount < Account
    attr_accessor :id, :balance

    def initialize(id, balance)
      super(id, balance)

      raise ArgumentError.new("balance must be >= 10") if balance < 10
    end

    def withdraw(amount)
      raise ArgumentError.new("amount must be >= 0") if amount < 0
      if amount < (@balance - 12)
        puts "Outputs a warning if the balance would go below $10"
        return @balance -= (amount + 2)
      else
        return @balance
      end
    end


    def interest(rate)
      raise ArgumentError.new("interest rate must be >= 0") if rate < 0
      interest_calculation = (@balance * (rate/100))
      @balance += interest_calculation
      return interest_calculation
    end

  end
end
