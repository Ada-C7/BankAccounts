require_relative 'account'

module Bank
  class SavingsAccount < Account

    def initialize(id, balance, timedate = nil)
      @min_opening_bal = 10
      @min_bal = 10
      super
    end

    def withdraw(withdrawal_amount)
      @min_bal = 10
      @fee = 2
      super
      # ensure_no_overdraft_for_fee(withdrawal_amount)
    end

    # def ensure_no_overdraft_for_fee(withdrawal_amount)
    #   raise ArgumentError.new if balance < (withdrawal_amount + @fee)
    #   return @balance
    # end
  end#class SavingsAccount
end#module Bank
