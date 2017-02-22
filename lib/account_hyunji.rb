module Bank
  class Account
    attr_reader :balance, :id
    def initialize(id, initial_balance)
      @balance = initial_balance
      @id = id
      if @balance < 0
        raise ArgumentError.new "Initial balance is negative"
      end
    end

    def withdraw(amount)
    end

    def deposit(amount)
    end
  end
end
