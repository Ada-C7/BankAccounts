module Bank
  class Account

    attr_reader :id, :balance, :owner

    def initialize(id, balance, owner=nil)
      raise ArgumentError if balance < 0

      @id = id
      @balance = balance
      @owner = owner
    end

    def add_owner owner
      if @owner.nil?
        @owner = owner
      else
        puts "This account is already owned by #{@owner.name}!"
      end
    end

    def withdraw(amount)
      raise ArgumentError if amount < 0

      if amount > @balance
        puts "Insufficient Funds"
        @balance
      else
        @balance -= amount
      end
    end

    def deposit(amount)
      raise ArgumentError if amount < 0

      @balance += amount
    end

  end
end
