module Bank
  class Account
    attr_reader :id, :balance

    def initialize(id, balance = 0)
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
    end
    def withdraw(amount)
      raise ArgumentError.new("amount must be >= 0") if amount < 0
      if amount > @balance
        puts "Warning: insufficient fund."
      else
        @balance = @balance - amount
      end
      return @balance
    end
    def deposit(amount)
      raise ArgumentError.new("amount must be >= 0") if amount < 0
      @balance = @balance + amount
      return @balance
    end
  end
end
