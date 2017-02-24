module Bank
  # CheckingAccount's responsibility is to maintian the balance of a checking account
  class CheckingAccount < Account
    attr_reader :id, :balance
    attr_accessor :check_count

    def initialize(id, balance, date = '')
      super(id, balance, date = '')
      # need to rename?
      @check_count = 0
    end

    def withdraw(withdrawal_amount)
      super(withdrawal_amount + 1)
    end

    def above_min_balance?(withdrawal_amount)
       @balance - withdrawal_amount + 10  >= 0
    end

    # I want to inherite the original withdraw method so here is that version
    # but is this readable? ...not really
    def withdraw_using_check(withdrawal_amount)
      #checks if the withdrawal will be above the min balance of -10
      return "Insufficient Funds" if @balance - withdrawal_amount <= -10
      # determines if the 2 dollar fee needs to be added
      @check_count < 3 ? withdrawal_amount : withdrawal_amount += 2
      #calls withdraw which will call the super withdraw and chance the balance
      withdraw(withdrawal_amount - 11)
      @check_count += 1
      @balance -=10
    end

    # re-wrote the withdraw_using_check as an instance method so it is more readable but now code is no so DRY
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

    # def check_amount_is_over_zero(amount)
    #   super(amount)
    # end

    def reset_checks
      @check_count = 0
    end

  end
end
