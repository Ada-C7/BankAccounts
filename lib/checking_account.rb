require_relative 'account'


module Bank
  class CheckingAccount < Account


    def initialize(id, balance, timedate = nil)
      super
      @number_of_checks = 0
      @fee = 1
      @check_fee = 2
      @min_bal = -10
    end

    def withdraw_using_check(withdrawal_amount)
      check_for_negative(withdrawal_amount)
      check_for_overdraft(withdrawal_amount)
      charge_fee_if_appropriate(3)
    end

    def check_for_overdraft(withdrawal_amount)
      @withdrawal_amount = withdrawal_amount
      overdraw_amount = @balance - withdrawal_amount
      add_checks
      if withdrawal_amount <= balance - @min_bal
        @balance -= withdrawal_amount
      elsif overdraw_amount < @min_bal
        puts "Balance will be more than $10 negative"
        @balance
      end
    end




    def charge_fee_if_appropriate(check_limit)
        if @number_of_checks > check_limit
          return @balance - @check_fee
        else
          return @balance
        end
    end
    def add_checks
      @number_of_checks += 1
    end

    def reset_checks
      @number_of_checks = 0
    end

  end#class CheckingAccount
end#module Bank
