require_relative 'account'


module Bank
  class CheckingAccount < Account
    attr_reader :counter

    def initialize(id, balance, timedate = nil)
      raise ArgumentError.new("balance must be greater than zero") if balance < 0
      @id = id
      @balance = balance
      @timedate = timedate
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
    end

    def check_for_overdraft(withdrawal_amount, limit)
      @withdrawal_amount = withdrawal_amount
      overdraw_amount = @balance - withdrawal_amount
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


  end#class CheckingAccount
end#module Bank
