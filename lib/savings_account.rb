require_relative 'account'

module Bank
  class SavingsAccount < Bank::Account
    attr_reader :id, :amount
    def initialize(id, balance)
      # super(id, balance)
      @id = id
      @balance = balance
      raise ArgumentError.new("balance must be greater than 10") if balance < 10
    end

    def withdraw(withdraw_amount)
      if @balance - (withdraw_amount + 2) < 10
        puts "balance must be >= 10"
        return @balance
      else
        return @balance = @balance - (withdraw_amount + 2)
      end
    end

    def add_interest(rate)
      if rate < 0
        puts "Requires a positive rate"
      else
        interest = @balance * rate
        @balance = @balance + (@balance * rate)
        return interest
      end
    end

    # a = Bank::SavingsAccount.new(1223, 5000)
    # puts a.withdraw(500)
    # puts a.balance


  end
end

# a = Bank::SavingsAccount.new(1000, 10000)
# puts a
