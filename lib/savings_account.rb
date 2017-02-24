module Bank
  class SavingsAccount < Account
    attr_reader :balance, :id, :opening_date

    def initialize(id, balance, date = '')
      raise ArgumentError if balance < 10
      super(id, balance, date = '')
    end

    # need to refractor this ...
    def withdraw(withdrawal_amount)
      @balance = super(withdrawal_amount + 2)
      if @balance < 10
        @balance = @balance + withdrawal_amount + 2
        puts "Your savings account balance must have 10 or more dollars at all times"
      end
      return @balance
    end

    def add_interest(rate)
      raise ArgumentError if rate < 0
      interest_added = @balance * rate/100
      @balance = @balance + interest_added
      return interest_added
    end
  end
end
