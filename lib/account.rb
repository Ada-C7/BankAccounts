module Bank
  class Account
    attr_reader :id
    attr_accessor :balance

    def initialize id, start_balance
      @id = id

      if start_balance >= 0
        @balance = start_balance
      else raise ArgumentError.new
      end
    end

    def withdraw(withdrawal_amount)

      if withdrawal_amount < 0
        raise ArgumentError.new
      elsif withdrawal_amount > @balance
        print "You are withdrawing too much!"
      else
        @balance -= withdrawal_amount
      end

      @balance

    end

  end
end
