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
      if @count_checks_cashed > 3
        amount += 2
      end

      if amount <=0
        raise ArgumentError.new "withdrawal must be greater than 0"
      elsif @balance - amount < -10
        puts "Insufficient funds"  #puts statement returns nil
        @balance #this is what is returned by this elsif
      else
        @count_checks_cashed += 1
        @balance -= amount
      end
      
    end


  end
end
