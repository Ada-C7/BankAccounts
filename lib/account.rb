module Bank
  class Account
    attr_reader :id, :balance

    def initialize(id, balance)
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
    end

    def withdraw(withdraw_amount)
      raise ArgumentError.new("error") if withdraw_amount < 0
        if (@balance - withdraw_amount) <0
           print "warning"
           return @balance
         end

        return @balance if (@balance -= withdraw_amount) >= 0
    end


    def deposit(amount)
    raise ArgumentError.new("error") if amount < 0
      @balance += amount
    end
  end
end
