module Bank
  class Account

    attr_accessor :id, :balance
    def initialize (id, initial_balance)
      if initial_balance < 0
        raise ArgumentError, 'You cannot use a negative number for your initial balance'
      end
      @id = id
      @balance = initial_balance
    end


    def withdraw(amount)
      raise ArgumentError.new("You do not have sufficient funds, to complete this transaction") if amount < 0

      if @balance - amount < 0
        puts "Your balance will be overdrawn"
        return @balance
      end
      @balance = @balance - amount
      return @balance
    end

    def deposit (amount)
      if amount < 0
        raise ArgumentError.new("You cannot deposit a negative number")
        return @balance
      end
      @balance = @balance + amount
      return @balance
    end
  end
end
