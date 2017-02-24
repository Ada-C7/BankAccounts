
module Bank
  FEE = 2.00

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
      # elsif @balance - withdraw_amount - FEE < 10.0
      #   return @balance
      else
        @balance -= withdraw_amount + FEE
      end
    end
  end#end of class
end#end of module
