module Bank
  class Account
    attr_reader :id, :balance

    def initialize(id, balance)
      @id = id
      @balance = balance
      raise ArgumentError, "You cannot have a negative balance" unless balance >= 0

    end

    def withdraw(amount)
      raise ArgumentError, "Withdrawals should be a positive number" unless amount >=0
      if amount <= @balance
        @balance = @balance - amount
      else
        puts "You do not have enough money in your account."
        @balance
      end
    end

    def deposit(amount)
      raise ArgumentError, "Deposits should be a positive number" unless amount >=0
      @balance = @balance + amount
    end
  end

  # class Owner(name, address)
  #   attr_reader :name, :address
  #
  #   def initialize
  #     @name = name
  #     @address = address
  #   end
  #
  #   def add_owner(id)
  #
  #   end
  # end
end
#
# account = Bank::Account.new(1337, 100.0)
# owner = Bank::Owner.new
# p owner
