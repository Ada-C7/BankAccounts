require_relative 'account'

module Bank


  class SavingsAccount < Account

    #Intializes with at least $10
    def initialize(id, balance, open_date=nil)
      raise ArgumentError.new "The balance must be at least $10" if balance < 10
      super(id, balance)
    end

    #Applies fees to withdrawal as well as not allowing balance
    #To go below 10
    def withdraw(amount)
      if (@balance - amount) < 10
        print "Warning! This will cause your balance to go below $10"
        return @balance
      end
      super(amount)
      if @balance - 2 < 10
        print "Warning! This will cause your balance to go below $10"
        @balance += amount
      else
        @balance -= 2
      end
      return @balance
    end

    #Method for calculating interest rate
    def interest(rate)
      raise ArgumentError.new "The rate must be a positive number" if rate < 0
      interest = @balance * rate/100
      @balance += interest
      return interest
    end
  end

end
