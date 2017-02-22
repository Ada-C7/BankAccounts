
# COPIED OVER FROM ALL
module Bank
  class Owner
    # attr_accessor
    # attr_reader
    def initialize(id, balance)
      unless balance >= 0
        raise ArgumentError.new "Starting balance is not valid."
      end
      @id = id
      @balance = balance
    end

    def withdraw(amount)
      unless amount > 0
        raise ArgumentError.new "Has to be a positive amount!"
      end
      if amount > @balance
        puts "Can't withdraw more than you have!"
      elsif amount == @balance
        puts "You're taking out all your funds!?"
        @balance -= amount
      else
        @balance -= amount
      end
      return @balance
    end

    def deposit(amount)
      unless amount > 0
        raise ArgumentError.new "Must deposit a positve amount!"
      end
      @balance += amount
      return @balance
    end
  end
end
