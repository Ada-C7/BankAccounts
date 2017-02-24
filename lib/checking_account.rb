module Bank
  CH_FEE = 1.00

  class CheckingAccount < Bank::Account
    def withdraw(withdraw_amount)
      if @balance - withdraw_amount - CH_FEE < 0
        print "Balance cannot be less than $0"
        return @balance
      else
        @balance -= withdraw_amount + CH_FEE
      end
    end#end of withdraw def

  end#end of Class
end#end of Module
