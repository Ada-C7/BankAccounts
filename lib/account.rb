# bank account that allows new accounts, deposit and withdrawals
# jou-jou sun
# last edit 2/21/17
module Bank
  class Account
    attr_reader :id, :balance

    def initialize(id, balance)
      @id = id
      @balance = balance
        if @balance < 0
          raise ArgumentError.new "The starting balance must be positive"
        end
    end

    def withdraw(withdrawal_amount)
      if withdrawal_amount < 0
        raise ArgumentError.new "Withdrawal must be positive"
      end
      if withdrawal_amount > @balance
        print "Account will be in negative with this withdrawal"
        return @balance
      else
        @balance -= withdrawal_amount
        return @balance
      end
    end

    def deposit(deposit)
      if deposit < 0
        raise ArgumentError.new "Deposit must be positive"
      end
      @balance += deposit
      return @balance
    end

  end #end of class

end #end of module
