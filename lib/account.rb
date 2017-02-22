
module Bank
  class Account
    attr_reader :id, :balance

    def initialize(id, balance) # method to initialize and accept two parameters...ID and starting balance
      @id = id

      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "Please enter a positive integer."
      end
    end

    def withdraw(withdrawal_amount) # method subtracts withdrawal amt from bal and return the updated bal

      if withdrawal_amount < 0
        raise ArgumentError.new "Please enter a positive integer."
      end

      if withdrawal_amount > balance
        print "Tried to withdraw #{ withdrawal_amount } when you only have #{ balance }." # needed to output something instead of raising an error
        return balance
      else
        bal_after_withdrawal = balance - withdrawal_amount
        @balance = bal_after_withdrawal
        return balance
      end
    end

    def deposit(deposit_amount) # method adds deposit amt to bal and return the updated bal
      bal_after_deposit = balance + deposit_amount

      if deposit_amount < 0
        raise ArgumentError.new "Please enter a positive integer."
      else
        @balance = bal_after_deposit
      end
      return balance
    end

    def balance_inquiry # method needs to let user access balance at any time
      puts @balance
    end
  end
end
