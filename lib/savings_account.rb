require_relative 'account'

module Bank
  class SavingsAccount < Account

    def initialize(id, balance, timedate = nil)
      super
      @min_opening_bal = 10
      @min_bal = 10
      check_opening_bal
    end

    def withdraw(withdrawal_amount)
      @min_bal = 10
      @fee = 2
      # ensure_no_overdraft_for_fee(withdrawal_amount)
      super
    end



    def add_interest(rate, time_in_months)
      raise ArgumentError.new "Please provide a positive rate" if rate <= 0
      interest = @balance * rate/100 * time_in_months
      @balance += interest
      interest
    end

  end#class SavingsAccount
end#module Bank
