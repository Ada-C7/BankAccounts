#require_relative 'account'

module Bank
  class CheckingAccount < Account

    def initialize(id, start_balance)
      super(id, start_balance)

    end

    def withdraw(withdrawal_amount)
      fee = 1.0
      
      if @balance - (withdrawal_amount + fee) < 0
        print "You're withdrawing too much."
        return @balance
      else
        @balance -= withdrawal_amount + fee
      end

    end


  end
end
