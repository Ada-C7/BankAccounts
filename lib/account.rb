module Bank
  class Account
    attr_reader :id, :balance
    def initialize(id, balance)
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
    end

    def withdraw(amount)
      raise ArgumentError.new("withdrawl must be >= 0") if amount < 0
      @balance -= amount
      return @balance if @balance >= 0
      puts "Requested withdrawl amount surpasses account balance."
      @balance += amount
    end

    def deposit(amount)
      raise ArgumentError.new("deposit must be >= 0") if amount < 0
      @balance += amount
    end
  end
end
