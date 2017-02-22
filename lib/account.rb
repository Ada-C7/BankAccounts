module Bank
  class Account

    attr_reader :id, :balance

    def initialize(id, balance)
      @id = id
      @balance = balance
      raise ArgumentError.new("balance must be >= 0") if balance < 0
    end

    def withdraw(amount)
        raise ArgumentError.new("amount must be >= 0") if amount < 0
      if @balance - amount < 0
        puts "whoops! you don't have that much money in your account! your balance is #{@balance}."
        return @balance
      else
        return @balance -= amount
      end
    end

    def deposit(amount)
      raise ArgumentError.new("amount must be >= 0") if amount < 0
      return @balance += amount
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
