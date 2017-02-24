
module Bank

  class SavingsAccount < Account

    def initialize(id, balance, date, owner = "Customer Name")
      super
      raise ArgumentError.new("Balance must be over $10.") if balance < 10
    end

    def withdraw(withdrawal_amount)
      if @balance < withdrawal_amount + 12
        print "There must always be at least $10 in your savings."
        return @balance
      end
      super
      @balance -= 2
    end

    def add_interest(rate)

    end

  end

end
