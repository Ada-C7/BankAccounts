module Bank
  class CheckingAccount < Bank::Account #inherits from Bank::Account
    def initialize(id, balance, open_date = nil)
      super(id, balance, open_date)
      @checks_used = 0
    end

    def withdraw(amount)
      super(amount + 1)
    end

    def withdraw_using_check(amount)
      raise ArgumentError.new "Requires a positive amount" if amount <= 0

      @checks_used +=1
      amount += 2 if @checks_used > 3

      if(balance - amount < -10)
        puts "That would make the account too in the negative"
      else
        @balance -= amount
      end
      return balance
    end

    def reset_checks
      @checks_used = 0
    end

  end #end of class CheckingAccount
end #end of module Bank
