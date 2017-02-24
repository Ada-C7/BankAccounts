# require_relative 'acccount'
module Bank

  class CheckingAccount < Account
    attr_reader :id, :balance
    attr_accessor :check_count

    def initialize(id, balance, date = '')
      super(id, balance, date = '')
      @check_count = 0
    end

    def withdraw(withdrawal_amount)
      @balance = super(withdrawal_amount + 1)
    end

    # I want the original withdraw method to call the insufficient funds so it has to call that method...
    # I could re-write a withdraw method for this
    def withdraw_using_check(withdrawal_amount)
      @check_count += 1
      @check_count <= 3 ? withdrawal_amount : withdrawal_amount += 2
      enough = ( @balance - withdrawal_amount >= -10 )
      @balance = withdraw(withdrawal_amount - 11)
      enough ? @balance -=10 : @balance
    end

    def reset_checks
      @check_count = 0
    end

  end
end
