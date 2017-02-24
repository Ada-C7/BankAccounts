require 'csv'
require 'date'
require_relative 'account'


module Bank

  class CheckingAccount < Account

    def initialize(id, balance, open_date='2010-12-21 12:21:12 -0800')
      super(id, balance, open_date)
      @free_checks_used = 0
    end

    def withdraw(withdrawal_amount)
      raise ArgumentError.new("Withdrawal amount must be >= 0") if withdrawal_amount < 0
      if withdrawal_amount > (@balance - 1)
        puts "You don't have enough in your account to withdraw that amount!"
      else @balance -= (withdrawal_amount + 1)
      end
      return @balance
    end

    def withdraw_using_check(withdrawal_amount)
      raise ArgumentError.new("Withdrawal amount must be >= 0") if withdrawal_amount < 0

      if @free_checks_used < 3
        if withdrawal_amount > (@balance + 10)
          puts "You don't have enough in your account to withdraw that amount, even with your $10 overdraft allowance!"
        else @balance -= (withdrawal_amount)
          @free_checks_used += 1
        end
      else
        if withdrawal_amount > (@balance + 10 - 2)
          puts "You don't have enough in your account to withdraw that amount and pay the check fee, even with your $10 overdraft allowance!"
        else @balance -= (withdrawal_amount +2)
        end
      end
      return @balance
    end

    def reset_checks
      @free_checks_used = 0
    end

    #withdraw_using_check(amount): The input amount gets taken out of the account as a result of a check withdrawal. Returns the updated account balance.
    # Allows the account to go into overdraft up to -$10 but not any lower
    # The user is allowed three free check uses in one month, but any subsequent use adds a $2 transaction fee

  end
end

#
# account = Bank::CheckingAccount.new(1337, 100)
#
# puts account.withdraw_using_check(110.01)
