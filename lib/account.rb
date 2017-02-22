module Bank
  class Account
    attr_reader :id, :balance
    def initialize(id, balance)
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
    end

    def withdraw(amount)
      if amount < 0
        raise ArgumentError.new "Negative amount entered for withdrawal"
      else
        new_balance = @balance - amount
        if new_balance < 0
          puts "Withdrawal amount greater than the current balance"
          @balance = @balance
        else
        @balance = new_balance
        end
      end
    end

    def deposit(amount)
      if amount < 0
        raise ArgumentError.new "Minus amount deposited"
      else
        new_balance = @balance + amount
        @balance = new_balance
      end

    end
  end
end
