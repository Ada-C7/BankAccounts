module Bank
  # SavingsAccount mainitains the balance of a savings account
  class SavingsAccount < Account
    attr_reader :balance, :id, :opening_date

    def initialize(id, balance, date = '')
      raise ArgumentError if balance < 10
      super(id, balance, date = '')
    end

    # this method will rewrite the balance as long at the withdrawal amount
    # meets certain conditions
    def withdraw(withdrawal_amount)
      return "Insufficient Funds" if @balance - withdrawal_amount - 2 < 10
      super(withdrawal_amount + 2)
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
