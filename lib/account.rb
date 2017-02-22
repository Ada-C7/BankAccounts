
module Bank

  class Account
    attr_reader :id, :owner, :balance

    def initialize(id, owner, balance)
      @id = id
      @owner = owner
      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "You cannot create a bank account with a negative balance, you goober."
      end
    end

    def withdraw(withdrawal_amount)
      if withdrawal_amount > 0
        if withdrawal_amount > @balance
          print "Uh oh! You have overdrawn your account, you doof!"
        else
          return @balance -= withdrawal_amount
        end
        return @balance
      else
        raise ArgumentError.new "You cannot withdraw a negative amount of money, you silly pants."
      end
    end

    def deposit(deposit_amount)
      if deposit_amount > 0
        @balance += deposit_amount
      else
        raise ArgumentError.new "You cannot deposit a negative amount of money, you goofball."
      end
    end

  end

end
