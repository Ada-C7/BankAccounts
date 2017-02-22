module Bank
  class Account
    attr_reader :id, :balance
    def initialize(id, balance)
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      if balance < 0
        then
        puts "balance must be >= 0"
      end

      @id = id
      @balance = balance
    end

    def withdraw(amount)
      if amount > 0
        if (@balance - amount) >= 0
          @balance -= amount
        else
          puts "You have insufficient funds"
        end
      else
        puts "You must withraw an amount greater than $0.00 dollars"
          raise ArgumentError.new("you must withdraw an amount greater than $0.00")
      end
      return @balance
    end

    def deposit(amount)
      if amount >= 0
        @balance += amount
        else
        puts "You must deposit an amount greater than $0.00 dollars"
        raise ArgumentError.new("you must deposit an amount greater than $0.00")
      end
      return @balance

    end
  end
end
