# Baseline
module Bank

  class Account

    attr_reader :balance, :id

    def initialize (id, initial_balnce)

      if initial_balnce >= 0
        @balance = initial_balnce
      else
        raise ArgumentError.new "An account can't be created with negative balance"
      end
      @id = id
    end

    def withdraw(amount)
      if amount < 0
        raise ArgumentError.new "Invalid negative amount"
      elsif amount <= @balance
          @balance -= amount
      else
        puts "You don't have sufficient funds. Max withdrawel amount is #{@balance}."
      end
      return @balance
    end

    def deposit(amount)
      if amount < 0
        raise ArgumentError.new "Invalid negative amount"
      else
        @balance += amount
      end
      return @balance
    end


  end



end
