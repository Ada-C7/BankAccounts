require_relative 'account'

module Bank

  class CheckingAccount < Account

    def initialize(id, balance)
      super(id, balance, nil, 1)

      if balance < 0
        raise ArgumentError.new "Amount too large, please enter a smaller amount."
      end
    end

    def withdraw_using_check(amount)
      if amount > @balance + 10
        raise ArgumentError.new "Amount too large, please enter a smaller amount."
      else
        @balance = @balance - amount
        return @balance
      end
    end
  end
end
