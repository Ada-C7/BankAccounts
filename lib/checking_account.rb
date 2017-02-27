require 'csv'
require_relative 'account'

module Bank
  class CheckingAccount < Account

    def initialize(id, balance)
      super(id, balance)
    end

    def withdraw(amount)
      if (@balance - amount) - 1 < 0
        puts "You've exceeded the balance"
        return @balance
      else
        @balance = (@balance - amount) - 1
        return @balance
      end
    end

    def withdraw_using_check(amount)
      check = 0 #need to double check this is right
      while check < 3 do
        if balance - amount < -10
          puts "You are not allowed an overdrft of more than $10."
        else
          @balance = @balance - amount
          return balance
        end
        while check > 3 do
          @balance = @balance - 2
          return @balance
        end
      end
    end

    def reset_checks(checks)
      if check > 3
        return check = 0
      end
    end
  end
end





# #withdraw_using_check(amount): The input amount gets taken out of the account as a result of a check withdrawal.
# Returns the updated account balance.
# Allows the account to go into overdraft up to -$10 but not any lower
# The user is allowed three free check uses in one month, but any subsequent use adds a $2 transaction fee
# #reset_checks: Resets the number of checks used to zero
