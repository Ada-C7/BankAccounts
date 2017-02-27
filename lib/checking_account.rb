require_relative '../lib/account.rb'

module Bank

  class CheckingAccount < Account
    attr_accessor :check_count
    def initialize(id, start_balance)
      super
      @check_count = 0
    end

    def withdraw(amount)
      super(amount + 1.0)
    end

    def withdraw_using_check(amount)
      if @check_count > 3
        amount = amount + 2.0
      end

      if amount <= 0
        raise ArgumentError.new "You cannot withdraw a negative amount"
      elsif @balance - amount < -10.0
        puts "Insufficient funds"
        return @balance
      else
        @check_count += 1
        return @balance -= amount
      end
    end

    def reset_checks
      @check_count = 0
    end
  end
end
