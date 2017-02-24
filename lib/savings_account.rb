require_relative 'account'

module Bank

  class SavingsAccount < Bank::Account

    def initialize(id, balance, min_balance = 10, date)
      super(id, balance, date)
      #@account = Bank::SavingsAccount.new
      @withdrawal_amount = 0
      @fee = 2.00
      @min_balance = min_balance
    end

    def check_for_min_balance(amount)
      if @min_balance <= 10
        raise ArgumentError.new "You can only open a new account with at least $10.00"
      else
        return "Great job. New savings account."
      end
    end


    def withdraw_fee(amount)
      @balance = @balance - (amount + @fee)
    end

    def min_balance(amount)
      @min_balance == 10.00

    end

    def add_interest(rate)
      updated_balance = @balance *= ()
      return updated_balance
    end

  end
end
