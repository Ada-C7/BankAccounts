module Bank
  class Account
    attr_reader :id, :balance

    def initialize(id, balance)
      @id = id
      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "Balance cannot be negative"
      end
    end

    def withdraw(withdrawal_amount)
      if withdrawal_amount <= @balance && withdrawal_amount >= 0
        @balance -= withdrawal_amount
      elsif withdrawal_amount < 0
        raise ArgumentError.new "You cannot withdraw a negative amount."
      else
        raise ArgumentError.new "You cannot withdraw more than you have in your account."
      end
    end
  end
end
