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
      if amount > @balance
        raise ArgumentError.new("withdrawal amount must be > 0") if @balance < 0 #@balance < amount
        puts "Account would go negative."
      elsif amount <= @balance
        @balance = @balance - amount
      end
      return @balance
    end

    def deposit(amount)
      raise ArgumentError.new("deposit amount must be >= 0") if amount < 0
      @balance = @balance + amount
      return @balance
    end
  end
end
