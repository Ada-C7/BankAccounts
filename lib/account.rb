module Bank
  class Account
    attr_reader :id, :balance
    def initialize(id, balance)
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      @id = id
      @balance = balance
    end

    def withdraw(amount)
      raise ArgumentError.new("Withdrawal amount must be positive.") if amount < 0
      if amount <= @balance
        @balance -= amount
      elsif amount > @balance
        print "Withdrawal denied. The balance in your account would go negative."
      end
      return @balance
      # TODO: implement withdraw
    end

    def deposit(amount)
      raise ArgumentError.new("Deposit amount must be positive.") if amount < 0
      if amount > 0
        @balance += amount
      end
      return @balance
      # TODO: implement deposit
    end
  end
end
