# Janice Lichtman's Bank Accounts - Wave 1

module Bank
  class Account
    attr_reader :id, :balance

    def initialize(id, balance)
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      @id = id
      @balance = balance
    end

    def withdraw(withdrawal_amount)
      raise ArgumentError.new("Withdrawal amount must be >= 0") if withdrawal_amount < 0
      if withdrawal_amount > @balance
        puts "You don't have enough in your account to withdraw that amount!"
      else @balance -= withdrawal_amount
      end
      return @balance
    end

    def deposit(deposit_amount)
      raise ArgumentError.new("Deposit amount must be >= 0") if deposit_amount < 0
      @balance += deposit_amount
    end
  end
end
