module Bank
  class Account
    attr_reader :id, :balance
    def initialize(id, balance)
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
    end

    def withdraw(amount)
      raise ArgumentError.new("withdrawal amount must be >= 0") if amount < 0

      if amount <= @balance
        return @balance -= amount
      elsif amount > @balance
        puts "Sorry, you don't have that much money."
        return @balance
      end
    end

    def deposit(amount)
      raise ArgumentError.new("deposit amount must be >= 0") if amount < 0 
      @balance += amount
    end

  end
end
