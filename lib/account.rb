module Bank
  class Account
    attr_reader :id
    attr_accessor :balance

    def initialize(id, balance)
      @id = id

      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "The balance must not be negative."
      end
    end

    def withdraw(withdrawal_amount)
      if withdrawal_amount < 0
        raise ArgumentError.new "The withdrawal amount must have a positive value."
      end

      if @balance - withdrawal_amount < 0
        puts "This withdrawal would create a negative balance."
        @balance
      else
        @balance = @balance - withdrawal_amount
      end
    end

    def deposit(deposit_amount)
      if deposit_amount < 0
        raise ArgumentError.new "The deposit amount must have a positive value."
      end
      @balance = @balance + deposit_amount
    end

  end
end
