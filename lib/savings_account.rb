
# require "awesome_print"
require 'account'

class SavingsAccount < Bank::Account

  def initialize(id, initial_balance)
    minimum_balance = 10.0
    raise ArgumentError.new "An account requires an initial balance of at least $10" if initial_balance < minimum_balance
    super(id, initial_balance, "1/1/2017", -1)
  end

  def withdraw(amount)
    minimum_balance = 10.0
    withdrawal_fee = 2.0

    if (@balance - amount - withdrawal_fee) >= minimum_balance
      @balance -= (amount + withdrawal_fee)
    else
      puts "Insufficient funds, balance would go below $10."
    end

    return @balance
  end

  def add_interest(rate)
    raise ArgumentError.new "Requires a positive interest rate." if rate < 0

    interest_amount = @balance * rate/100.0
    @balance += interest_amount
    return interest_amount
  end
end
