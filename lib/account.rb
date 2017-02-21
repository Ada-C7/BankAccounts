module Bank
  class Account


    def initialize (id, balance)
      @id = id
      @balance = balance

    end

    def withdraw(money_to_withdraw)
      @balance = @balance - money_to_withdraw
    end

    def deposit(money_to_deposit)
      @balance = @balance + money_to_deposit
    end

  end

end
