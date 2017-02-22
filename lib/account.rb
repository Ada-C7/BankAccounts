module Bank

  class Account
    attr_reader :balance, :id


    def initialize(account_id, initial_balance, owner_info = {})
      if initial_balance >= 0
        @balance = initial_balance
      else
        raise ArgumentError.new "initial balance must be greater or equal to 0"
      end
      @id = account_id
      @owner = owner_info
    end

    def withdraw(withdrawl_amount)
      raise ArgumentError.new("withdrawl must be greater than 0") if withdrawl_amount < 0

      if @balance - withdrawl_amount >= 0
        @balance -= withdrawl_amount
      else
        print "your balance will be negative"
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
