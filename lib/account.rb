module Bank
  class Account
    attr_reader :id
    attr_accessor :balance

    def initialize(id, balance)
      raise ArgumentError.new("balance must be >=0") if balance < 0
      @id = id
      @balance = balance

    end

    def withdraw(withdrawal_amount)
      raise ArgumentError.new "The withdrawal amount must have a positive value." if withdrawal_amount < 0

      if @balance - withdrawal_amount < 0
        puts "This withdrawal would create a negative balance."
        @balance
      else
        @balance -= withdrawal_amount
      end
    end

    def deposit(deposit_amount)
      if deposit_amount < 0
        raise ArgumentError.new "The deposit amount must have a positive value."
      end
      @balance += deposit_amount
    end

  end
end
