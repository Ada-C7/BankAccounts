#require_relative 'account'

module Bank
  class CheckingAccount < Account

    def initialize(id, start_balance)
      super(id, start_balance)

    end

    def withdraw(withdrawal_amount)
      super(withdrawal_amount)

      fee = 1.0
      @balance -= fee
    end


  end
end
