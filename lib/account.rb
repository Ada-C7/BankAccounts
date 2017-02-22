require 'owner'

module Bank
  class Account
    attr_reader :id, :balance

    def initialize(id, balance)
      @id = id

      if balance >= 0
        @balance = balance
      else #throws error if negative balance is given
        raise ArgumentError.new "Balance cannot be negative"
      end

    end

    def withdraw(withdrawal_amount)

      if withdrawal_amount < 0 #throws error if withdrawal is negative
        raise ArgumentError.new "You cannot withdraw a negative amount."

      elsif withdrawal_amount <= @balance
        @balance -= withdrawal_amount

      else #gives warning if withdrawal is more than balance
        puts "You cannot withdraw more than you have in your account."
        @balance
      end

    end

    def deposit(deposit_amount)

      if deposit_amount > 0
        @balance += deposit_amount
      else #throws error if deposit is negative
        raise ArgumentError.new "You must deposit a positive amount."
      end

    end

  end
end
