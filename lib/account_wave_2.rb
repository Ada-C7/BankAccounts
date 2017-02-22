module Bank
  class Account

    def self.all
    end

    attr_reader :id, :balance, :owner
    def initialize(id, balance, owner)
      if balance < 0
        raise ArgumentError.new "Can't be negative starting balance"
      end
      @id = id
      @balance = balance
      @owner = owner
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
    attr_reader :name, :address
    def initialize(name, address)
      @name = name
      @address = address
    end
  end
end
