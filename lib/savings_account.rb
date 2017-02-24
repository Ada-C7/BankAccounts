require_relative 'account'

module Bank

  class SavingsAccount < Bank::Account

    def initialize(id, balance, date)
      super(id, balance, date)
      @minimum_balance

    end

    def new_10(opening_balance)
      if @balance >= 0
        @new_account  #Account.new(balance)
      else
        raise ArgumentError.new "You can only open a new account with at least $10.00)"
      end
    end

    def withdraw_fee(amount)
      @balance -= 2.00
    end

    def minimum_balance(amount)
    @minimum_balance == 10.00



    end

    def add_interest(rate)
      updated_balance = @balance *= ()
      return updated_balance
    end

  end
end
