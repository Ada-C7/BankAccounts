module Bank

  class Account

    attr_reader :id, :balance

    def initialize (id, balance)
      @id = id
      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "The initial balance must not be a negative number"
      end
    end

    def withdraw(money_to_withdraw)
      if money_to_withdraw > @balance
        puts "Amount to withdraw must be greater than balance"
        start_balance = @balance
        updated_balance = start_balance
      else
        start_balance = @balance
        updated_balance = @balance - money_to_withdraw
        @balance = updated_balance
      end
    end

    def deposit(money_to_deposit)
      @balance = @balance + money_to_deposit
    end

  end

end
