module Bank

  class SavingsAccount < Bank::Account

    def initialize(id, balance, date)
      super(id, balance, date)
      @minimum_balance

    end

    def new_10
    end

    def withdraw_fee(amount)
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
