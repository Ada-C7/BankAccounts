require_relative 'account'


module Bank
  class CheckingAccount < Account


    def initialize(id, balance, timedate = nil)
      raise ArgumentError.new("balance must be greater than zero") if balance < 0
      @id = id
      @balance = balance
      @timedate = timedate
      @number_of_checks = 0
    end

    def withdraw(withdrawal_amount)
      super
      if @balance < withdrawal_amount
        @balance
      else
        @balance -= 1
      end
    end



    def withdraw_using_check(withdrawal_amount)

      check_for_negative_withdrawal(withdrawal_amount)
      check_for_overdraft(withdrawal_amount, 10)
      charge_fee_if_appropriate(3, 2)


    end

    def check_for_overdraft(withdrawal_amount, limit)
      @withdrawal_amount = withdrawal_amount
      overdraw_amount = @balance - withdrawal_amount
      add_checks
      if withdrawal_amount <= balance + limit
        @balance -= withdrawal_amount
      elsif overdraw_amount < -10
        puts "Balance will be more than $10 negative"
        @balance
      end
    end

    def check_for_negative_withdrawal(withdrawal_amount)
      raise ArgumentError.new "You cannot withdraw a negative amount" if withdrawal_amount < 0
    end

    def charge_fee_if_appropriate(check_limit, fee)
        if @number_of_checks > check_limit
          return @balance - fee
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
