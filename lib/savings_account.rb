
require_relative 'account'

module Bank
  class SavingsAccount < Bank::Account
    def initialize(id, balance, open_date = nil)
      raise ArgumentError.new "Requires a balance of at least $10" if balance < 10
      super(id, balance, open_date)
    end

    def withdraw(amount)
      if (balance - amount - 2 < 10)
        puts "Balance below $10"
      else
        super(amount + 2)
      end
      return balance
    end

    def add_interest(interest_rate)
      raise ArgumentError.new "Interest Rate must be positive" if interest_rate <= 0
      interest = balance * interest_rate / 100.0
      deposit(interest)
      return interest
    end
  end # end of class SavingsAccount
end # end of module Bank
