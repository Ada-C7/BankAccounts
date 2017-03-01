module Bank
  SV_FEE = 2.00

  class SavingsAccount < Bank::Account

    def initialize(id, balance)
      super(id, balance)
      if @balance < 10.0
        raise ArgumentError.new "The starting balance must over $10.00"
      end#end of if
    end#end of def

    def withdraw(withdraw_amount)
      # "Outputs a warning if the balance would go below $10"
      # "Doesn't modify the balance if it would go below $10"
      # "Doesn't modify the balance if the fee would put it below $10"

      if @balance - withdraw_amount < 10.0
        print "Balance cannot be less than $10"
        return @balance
      elsif @balance - withdraw_amount - SV_FEE < 10.0
        return @balance
      else
        @balance -= withdraw_amount + SV_FEE
      end
    end#end of withdraw def

    def add_interest(rate)
      if rate < 0
        raise ArgumentError.new "The interest rate must be positive"
      else
        interest = balance * rate/100
        @balance = @balance + interest
        return interest
      end#end of if/else
    end#end of interest def

  end#end of Class
end#end of module
