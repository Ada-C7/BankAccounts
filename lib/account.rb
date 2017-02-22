module Bank

  class Account
    attr_accessor :id, :balance

    # creates a new account with an ID and an initial balance
    def initialize(id, balance)
      @id = id

      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "Your balance must be greater than 0"
      end
    end

    # creates a withdraw method that accepts a single parameter
    # which represents the amount of money that will be withdrawn.
    # and returns the updated account balance.
    def withdraw(withdrawal_amount)
      if withdrawal_amount >= 0
        if withdrawal_amount <= @balance
          @balance -= withdrawal_amount
        else
          print "Insufficent funds."
        end
      else
        raise ArgumentError.new "Your withdrawal amount must be greater than 0"
      end

      return @balance
    end

    # creates a deposit method that accepts a single parameter
    # which represents the amount of money that will be deposited
    # and returns the updated account balance.
    def deposit
    end

    # creates a check_balance method to access
    # the current balance of an account at any time.
    def check_balance
    end
  end
end
