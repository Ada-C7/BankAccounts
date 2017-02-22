module Bank
  class Account
    attr_reader :id, :balance
    def initialize(id, balance)
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      # raise ArgumentError.new("") #I AM HERE!!!
      @id = id
      @balance = balance
    end

    def withdraw(amount)
      if amount > @balance
        raise ArgumentError.new("withdrawal amount must be > 0") if @balance < 0 #@balance < amount
        puts "Account would go negative."
      elsif amount < @balance
        @balance = @balance - amount
      end
      return @balance
    end

    def deposit(amount)
      # if amount < 0
      #   .must_raise
      # end
      @balance = @balance + amount
      return @balance
    end
  end
end

# test_1 = Bank::Account.new(200, 50)
# test_1.withdraw(100)
