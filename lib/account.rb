
module Bank
  class Account
    attr_reader :balance

    def initialize(id, balance) # method to initialize and accept two parameters...ID and starting balance
      @balance = 0
    end

    def withdraw(withdrawal_amount) # method needs to subtract withdrawal amt from balance and return the updated balance
      bal_after_withdrawal = @balance - withdrawal_amount
      return bal_after_withdrawal
    end

    def deposit(deposit_amount) # method needs to add deposit amt to balance and return the updated balance
      bal_after_deposit = @balance + deposit_amount
      return bal_after_deposit
    end

    def balance_inquiry # method needs to let user access balance at any time
      puts @balance
    end

  end
end
