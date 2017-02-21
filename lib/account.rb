module Bank

  class Account
    attr_accessor :balance, :id


    def initialize(account_id, initial_balance)
      if initial_balance >= 0
        @balance = initial_balance
      else
        raise ArgumentError.new "initial balance must be greater or equal to 0"
      end
      @id = account_id
    end

    def withdraw(withdrawl_amount)
      if withdrawl_amount > 0
        if @balance - withdrawl_amount >= 0
          @balance -= withdrawl_amount
        else
          print "your balance will be negative"
          return @balance
        end
      else
        raise ArgumentError.new "withdrawl must be greater than 0"
        return @balance
      end
    end

    def deposit(deposit_amount)
      if deposit_amount > 0
        @balance += deposit_amount
        return @balance
      else
        raise ArgumentError.new "deposits must be greater than 0"
        return @balance
      end
    end

    def balance
      return @balance
    end

  end
end
