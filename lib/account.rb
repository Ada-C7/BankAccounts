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
      if money_to_withdraw > 0 #requires positive withdrawal amount
        if money_to_withdraw > @balance #requires withdrawal amount less than balance
          puts "Amount to withdraw must be greater than balance"
          start_balance = @balance
          updated_balance = start_balance
          @balance = updated_balance
        else
          start_balance = @balance
          updated_balance = @balance - money_to_withdraw
          @balance = updated_balance
        end
      else
        raise ArgumentError.new "The amount to withdraw must be greater than zero"
      end
    end

    def deposit(money_to_deposit)
      if money_to_deposit > 0
        start_balance = @balance
        updated_balance = start_balance + money_to_deposit
        @balance = updated_balance
      else
        raise ArgumentError.new "The deposit amount must be greater than zero"
      end
    end

  end

end
