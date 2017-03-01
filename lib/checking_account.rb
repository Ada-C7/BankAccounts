require 'CSV'
require_relative 'account.rb'
require 'pry'

module Bank

  # Created CheckingAccount class that is a child of the Account class
  class CheckingAccount < Bank::Account
    attr_accessor :used_checks

    def initialize(id, balance, open_date = nil)

      super(id, balance, open_date = nil)
      @used_checks = 0
    end

    def withdraw(amount)

      raise ArgumentError.new "Your balance cannot go below $0.00" if (amount + 1 > @balance)

      super(amount)
      @balance -= 1
    end

    # withdraw_using_check(amount): The input amount gets taken out of the account
    # as a result of a check withdrawal. Returns the updated account balance.
    # Allows the account to go into overdraft up to -$10 but not any lower
    # The user is allowed three free check uses in one month, but any subsequent
    # use adds a $2 transaction fee
    def withdraw_using_check(amount)

      raise ArgumentError.new "You can only overdraft up to -$10.00" if (@balance - amount < -10)
      raise ArgumentError.new "You must withdrawal a positive amount." if amount < 0

      @balance -= amount
      @used_checks += 1

      if @used_checks > 3
        @balance -= 2
      end

      return @balance
    end

    #reset_checks: Resets the number of checks used to zero
    def reset_checks
      @used_checks = 0
    end
  end
end

# n = Bank::CheckingAccount.new(1 ,100)
# puts n.withdraw(20)
