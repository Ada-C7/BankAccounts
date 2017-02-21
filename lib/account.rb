module Bank
  class Account

    attr_reader :id, :balance

    def initialize(id, balance)
      raise ArgumentError if balance < 0

      @id = id
      @balance = balance
    end

    def withdraw(amount)
      raise ArgumentError if amount < 0

      if amount > @balance
        puts "Insufficient Funds"
        @balance
      else
        @balance -= amount
      end
    end

    def deposit(amount)
      raise ArgumentError if amount < 0

      @balance += amount
    end

  end
end
