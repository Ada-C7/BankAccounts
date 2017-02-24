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

  end
end
