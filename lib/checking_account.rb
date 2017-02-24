require_relative 'account'

module Bank

  class CheckingAccount < Bank::Account
    attr_accessor :checks_used

    def initialize(id, balance)
      super
      reset_checks
    end

    def withdraw(amount)
      @withdrawal_fee = 1
      super
    end

    def withdraw_using_check(amount)
      raise ArgumentError.new ("Withdrawal must be >=0") if amount < 0
      balance_limit = -10

      if @checks_used >= 3
        withdrawal_fee = 2
      else
        withdrawal_fee = 0
      end

      if @balance - amount - withdrawal_fee < balance_limit
        puts "This withdrawal would create a balance below #{balance_limit}."
        @balance
      else
        @checks_used += 1
        @balance -= (amount + withdrawal_fee)
      end

    end

    def reset_checks
      @checks_used = 0
    end

  end
end
