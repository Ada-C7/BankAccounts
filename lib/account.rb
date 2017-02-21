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
      if new_withdrawal <=0
        raise ArgumentError.new "You must withdraw a positive amount"
      elsif new_withdrawal > @balance
        puts "You do not have enough money to make that withdrawal"
        @balance
      else
        @balance -= new_withdrawal
      end
    end

    def deposit(new_deposit)
      if new_deposit <= 0
        raise ArgumentError.new "Your deposit amount must have a positive value"
        
      else
        @balance += new_deposit
      end

    end

  end
end
