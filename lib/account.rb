module Bank

  class Account
    attr_reader :id
    attr_accessor :balance

    def initialize(id, balance)
      @id = id
      if balance >= 0
      @balance = balance
      else
        raise ArgumentError.new "The balance must be 0 or above"
      end
    end

    def withdraw(withdrawal)
      if withdrawal < 0
        raise ArgumentError.new "The amount withdrawn must be
        a positive number"
      end
      if (@balance - withdrawal < 0)
        print "Warning! Withdrawing this amount will put your
        balance in the negative"
        return @balance
      else
        return @balance = @balance - withdrawal
      end
    end

    def deposit(deposit)
      if deposit < 0
        raise ArgumentError.new "The deposit must be a positive
        amount"
      else
        @balance = @balance + deposit
      end
    end

  end


end
