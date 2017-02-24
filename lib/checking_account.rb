require 'csv'
require_relative 'account'

# CheckingAccount class to inherit behavior from the Account class
module Bank
  class CheckingAccount < Account
    attr_reader :balance

    def initialize(id, balance)
      #super(id, balance)
      @balance = balance
      # we want to use balance from Account and make sure it doesn't dip below -10
    end

    def withdraw(withdrawal_amount)

      super( withdrawal_amount + 1 )

    end

    def withdraw_using_check(amount)
      raise ArgumentError.new("Withdraw amount must be >= 0") if amount < 0

      fee = 1
      total_check_amount = amount + fee

      if balance - total_check_amount < -10.0
        puts "You're withdraw request must leave your balance >= -$10"
        return @balance
      else
        @balance -= total_check_amount
      end
      return @balance

    end

    def rest_checks

    end

  end
end
