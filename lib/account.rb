module Bank
  class Account



    def initialize (id, balance)
      @id = id
      @balance = balance

    end


    def withdraw(money_to_withdraw)
      @balance = @balance - money_to_withdraw
    end

  end

end
