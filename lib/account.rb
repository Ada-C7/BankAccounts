
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

    def withdraw(withdrawal_amount) # method needs to subtract withdrawal amt from bal and return the updated bal
      bal_after_withdrawal = balance - withdrawal_amount

      if withdrawal_amount > balance
        raise ArgumentError.new "You cannot withdraw that amount right now, please enter a smaller withdrawal amount."
      else
        @balance = bal_after_withdrawal # is this right??
        return balance
      end
    end

    def deposit(deposit_amount) # method needs to add deposit amt to bal and return the updated bal
      bal_after_deposit = @balance + deposit_amount
      return bal_after_deposit
    end

    def balance_inquiry # method needs to let user access balance at any time
      puts @balance
    end
  end
  end
