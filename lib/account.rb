module Bank
  class Account

    attr_reader :id, :balance
    def initialize(id, balance)
      if balance < 0
        raise ArgumentError.new "Can't be negative starting balance"
      end
      @id = id
      @balance = balance
    end

    def withdraw(withdrawal_amount)
      if withdrawal_amount > @balance
        puts "You cannot withdraw more than you have in your account!"
        @balance = @balance
      elsif withdrawal_amount < 0
        raise ArgumentError.new "You cannot withdraw a negative amount."
      else
        @balance -= withdrawal_amount
      end
    end

    def deposit(deposit_amount)
      if deposit_amount < 0
        raise ArgumentError.new "Cannot deposit a negative amount."
      end
      @balance += deposit_amount
    end


  end

  class Owner
  end
end
