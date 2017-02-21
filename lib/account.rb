# Baseline
module Bank

  class Account

    attr_reader :balance

    def initialize (id, initial_balnce)
      @id = id
      if initial_balnce >= 0
        @balance = initial_balnce
      else
        raise ArgumentError.new "An account can't be created with negative balance"
    end


    end

    def withdraw(amount)
      @balance -= amount
    end

    def deposit(amount)

      @balance += amount
    end


  end



end
