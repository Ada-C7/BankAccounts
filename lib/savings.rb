
module Bank

  class SavingsAccount < Account

    attr_accessor :interest

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
      raise ArgumentError.new("You can't calculate negative interest.") if rate < 0
      @interest = @balance * rate / 100
      @balance += @interest
    end

  end

end
