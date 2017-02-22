module Bank
  class Account
    attr_reader :id
    attr_accessor :balance


    def initialize(id, balance)
      raise ArgumentError.new("balance must be > 0") if balance < 0

      @id = id
      @balance = balance

    end

    def withdraw(amount)
      if amount < 0
        raise ArgumentError.new "Requires a positive withdrawal amount"
      elsif @balance < amount
        puts "Warning, you don't have enough funds"
        return @balance
      else
        @balance -= amount
      end

    end


    def deposit(amount)
      if amount < 0
        raise ArgumentError.new "Requires a positive deposit amount"
      else
        @balance += amount
      end
    end
  end
end
