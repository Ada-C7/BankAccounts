require 'csv'
require_relative 'account'
# attr_accessor :id
#  inherit behavior from the Account class.
module Bank
  class SavingsAccount < Account

    def initialize(id, balance)
      super(id, balance)
      raise ArgumentError.new("Balance must be at least $10") if balance < 10
    end

    # # The initial balance cannot be less than $10. If it is, this will raise an ArgumentError
    # def starting_balance(balance)
    #   raise ArgumentError.new("Balance must be at least $10") if balance < 10
    #   return balance
    # end

    # Each withdrawal 'transaction' incurs a fee of $2 that is taken out of the balance.
    def withdrawal(amount)
      if @balance - amount - 2 < 10
        puts "Balance cannot go below %10"
        return @balance
      else
        @balance = (@balance - amount) - 2
        return @balance
      end
    end

    def add_interest(rate)
      interest = @balance * (rate/100)
      @balance = @balance + interest
      return interest
    end
  end
end





# It should include the following new method:
#
# #add_interest(rate): Calculate the interest on the balance and add the interest
#to the balance. Return the interest that was calculated and added to the balance (not the updated balance).
# Input rate is assumed to be a percentage (i.e. 0.25).
# The formula for calculating interest is balance * rate/100
# Example: If the interest rate is 0.25 and the balance is $10,000, then the interest that is returned is $25 and the new balance becomes $10,025.
