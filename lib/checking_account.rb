module Bank
  class CheckingAccount < Account
    def initialize id, balance, opendate = "1999-03-27 11:30:09 -0800"
      super
      @count_checks_cashed = 0
    end

    def withdraw amount  #this is updating the withdraw method in the Account class
      super(amount + 1) # +1 for the transaction fee
    end

    def reset_checks #new method
      @count_checks_cashed = 0
    end

    def withdraw_using_check amount  #new method
      #if > 3 checks, then charge a $2 check transaction fee
      #update number of checks cashed counter
      #can overdraft to -10 (balance)
      #returns updated account balance
      #total_checks_cashed += 1
    end


  end
end
