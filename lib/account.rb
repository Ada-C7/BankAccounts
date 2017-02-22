module Bank
  class Account
    attr_reader :id, :balance

    def initialize(id, balance)
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      @id = id
      @balance = balance
    end

    def withdraw(amount)
      raise ArgumentError.new ("You can't withdraw negative
      money here!") if amount < 0

      if amount <= balance
        @balance -= amount
      else
        puts "You don't have that much money. Try again"
      end
      return @balance
    end

    def deposit(amount)
      raise ArgumentError.new ("We don't want your debt (negative money)  here!") if amount < 0

      @balance += amount
      return @balance
    end
  end
end
