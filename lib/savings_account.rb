require_relative 'account'
module Bank
  class SavingsAccount < Bank::Account
    attr_reader :id, :balance

    def initialize(id, balance = 10)
      raise ArgumentError.new("balance must be >= 10") if balance < 10

      @id = id
      @balance = balance
    end

    def withdraw(amount)
      new_balance = @balance - (amount+2)
      if new_balance < 10
        puts "Warning: insufficient fund."
        return @balance
      end
      @balance = new_balance
    end
end
end
