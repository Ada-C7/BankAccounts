require_relative 'account'

module Bank
  class SavingsAccount < Account

    def initialize(id, balance, timedate = nil)
      super
    end

    def withdraw(withdrawal_amount)
      @fee = 2
      super
    end

  end#class SavingsAccount
end#module Bank
