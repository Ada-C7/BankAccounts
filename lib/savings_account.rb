require_relative 'account'

module Bank

  class SavingsAccount < Bank::Account

    def initialize(id, balance, min_balance = 10, date)
      super(id, balance, date)
      #@account = Bank::SavingsAccount.new
      @fee = 2.00
      @min_balance = 10

    end

    def check_for_min_balance(amount)
      if @min_balance <= 10
        raise ArgumentError.new "You can only open a new account with at least $10.00"
      else
        return "Great job. New savings account."
      end
    end

    def withdraw_fee(amount)
      updated_balance = @balance - amount - @fee
      if updated_balance < @min_balance
        return @balance
      else
        @balance = updated_balance
    end
  end

    def add_interest(rate)
      updated_balance = @balance *= ()
      return updated_balance
    end

  end
end
