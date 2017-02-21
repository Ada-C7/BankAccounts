module Bank
  class Account
    attr_reader :id, :balance

    def initialize id, balance
      @id = id
      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "Initial balance must be more than zero."
      end
      
    end

    def withdraw(new_withdrawal)

    end

    def deposit(new_deposit)

    end

  end
end
