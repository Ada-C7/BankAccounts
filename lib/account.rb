module Bank
  class Account

    attr_reader :id, :balance, :owner

    def initialize(id, balance, owner=nil)
      raise ArgumentError.new("Balance cannot be negative.") if balance < 0

      @id = id
      @balance = balance
      @owner = owner
    end

    def add_owner owner
      if @owner.nil?
        @owner = owner
      else
        raise ArgumentError.new("The account already has an owner.")
      end
    end

    def withdraw(amount)
      raise ArgumentError.new("The withdrawal amount must be positive.") if amount < 0

      if amount > @balance
        puts "Insufficient Funds"
        @balance
      else
        @balance -= amount
      end
    end

    def deposit(amount)
      raise ArgumentError.new("The deposit amount must be positive.") if amount < 0

      @balance += amount
    end

  end
end
