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
      end

      new_balance = @balance - withdrawal_amount

      if new_balance < 0
        print "You are withdrawing too much!"
      else
        @balance = new_balance
      end

      @balance

    end

  end
end
