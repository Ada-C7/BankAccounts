module Bank
  CH_FEE = 1.00
  OVR_FEE = 2.00

  class CheckingAccount < Bank::Account
    attr_reader :count

    def initialize(id, balance)
      super(id, balance)
      @count = 0
    end

    def withdraw(withdraw_amount)
      if @balance - withdraw_amount - CH_FEE < 0
        print "Balance cannot be less than $0"
        return @balance
      else
        @balance -= withdraw_amount + CH_FEE
      end
    end#end of withdraw def

    def withdraw_using_check(amount)
      if amount < 0
        print "Withdrawal must be positive"
      end
      if @balance - amount < -10.0
        print "Overdraft limit of -$10.00 is reached"
        return @balance
      elsif @count < 3
        @count += 1
        @balance -= amount
      elsif @count >= 3
        @count += 1
        @balance -= amount + 2.00
      end#end of if loop
    end#end of withdraw_using_check method

    def reset_checks
      @count = 0
    end
    
  end#end of Class
end#end of Module
