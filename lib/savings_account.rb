
module Bank
  FEE = 2.00

  class SavingsAccount < Bank::Account

    def initialize(id, balance)
      super(id, balance)
      if @balance < 10
        raise ArgumentError.new "The starting balance must over $10.00"
      end#end of if
    end#end of def

    def withdraw(withdraw_amount)
      super(withdraw_amount)
      @balance -= FEE
      return @balance
    end

  end#end of class
end#end of module
