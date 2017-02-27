require_relative 'account'

module Bank

  class CheckingAccount < Account
    attr_reader :checks_used

    def initialize(id, balance)
      super(id, balance, nil, 1)
      @checks_used = 0

      if balance < 0
        raise ArgumentError.new "Amount too large, please enter a smaller amount."
      end
    end

    def withdraw_using_check(amount)
      fee = 0
      if checks_used >= 3                    # this allows us to reassign the variable based on the number of check uses so when we call the fee in our next if statement, it's the correct $ amt
        fee = 2
      end

      if amount < 0
        raise ArgumentError.new "Error. Please enter a positive amount."
      elsif amount > @balance + 10 + fee
        puts "Amount too large, please enter a smaller amount."
        return @balance
      else
        @balance = @balance - (amount + fee)
        @checks_used +=1
        return @balance
      end
    end

    def reset_checks
      @checks_used = 0
    end
  end
end
