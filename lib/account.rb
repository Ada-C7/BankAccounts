module Bank

  class Account

    attr_reader :id
    attr_accessor :balance

    def initialize(id, balance)
      @id = id

      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "Account balance should not start with a negative number"
      end

    end #end of initialize

    def withdraw(withdrawal_amount)
      if withdrawal_amount < 0
        raise ArgumentError.new "Withdrawal amount cannot be negative number"
      else
        if @balance < withdrawal_amount
          print "Your account is going to be overdrawn"
          @balance = @balance
        elsif @balance >= withdrawal_amount
          return @balance -= withdrawal_amount
        end
      end

    end #end of withdraw method

    def deposit(deposit_amount)
      if deposit_amount < 0
        raise ArgumentError.new "Deposit amount cannot be negative number"
      else
        @balance += deposit_amount
      end

    end #end of deposit method

  end #end of class

end #end of module
