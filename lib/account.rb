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

    def positive_amount(amount)
      if amount > 0
        true
      else
        raise ArgumentError.new "Invalid negative amount"
      end

    end

    def withdraw(amount)
      while positive_amount(amount)
        if amount <= @balance
          @balance -= amount
        else
          raise ArgumentError.new "You don't have sufficient funds. Max withdrawel amount is #{@balance}."
          @balance -= amount
        end
        return @balance
      end
    end

    def deposit(amount)
        if positive_amount(amount)
          @balance += amount
      end

    end


  end



end
