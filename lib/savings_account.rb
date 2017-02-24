module Bank
  class SavingsAccount < Account
    def initialize(id, balance)
      @id = id
      @balance = balance
      raise ArgumentError.new("balance must be >= 10") if balance < 10
    end

    def withdraw(amount)
      amount += 2
      raise ArgumentError.new("withdrawal amount must be >= 0") if amount < 0
      if (@balance - amount) < 10
        puts "whoops! you don't have that much money in your account! your balance is #{@balance}."
        return @balance
      else
        return @balance -= amount
      end
    end

    def add_interest(rate)
      raise ArgumentError.new("interest rate must be > 0") if rate < 0
      interest = @balance * rate/100
      @balance += interest
      return interest
    end
  end
end
