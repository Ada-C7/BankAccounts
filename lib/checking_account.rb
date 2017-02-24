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

    # I want to inherite the original withdraw method so here is that version
    # but is this readable? ...not really
    def withdraw_using_check(withdrawal_amount)
      enough = ( @balance - withdrawal_amount + 10 ) >= 0
      @check_count < 3 ? withdrawal_amount : withdrawal_amount += 2
      # you need to call withdraw even if enough is false, because
      # withdrawl will print the error message and check that amount is greater than zero
      # this method is calling the checking_account withdraw which then calls the account withdraw method...
      @balance = withdraw(withdrawal_amount - 11)
      if enough
        @check_count += 1
        return @balance -=10
      else
        return @balance
      end
    end

    # re-wrote the withdraw_using_check as CheckingAccount instance method so it is more readable
    # def withdraw_using_check(withdrawal_amount)
    #   check_amount_is_over_zero(withdrawal_amount)
    #   @check_count < 3 ? withdrawal_amount : withdrawal_amount += 2
    #   if @balance - withdrawal_amount >= -10
    #     @check_count += 1
    #     return @balance = @balance - withdrawal_amount
    #   else
    #     puts "Insufficient funds"
    #     return @balance
    #   end
    # end

    def check_amount_is_over_zero(amount)
      super(amount)
    end

    def reset_checks
      @check_count = 0
    end

  end
end
