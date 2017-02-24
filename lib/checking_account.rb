require_relative 'account'

module Bank

  class CheckingAccount < Bank::Account
    attr_accessor :checks_used

    def initialize(id, balance)
      super
      reset_checks
    end

    def withdraw(amount)
      @withdrawal_fee = 1
      super
      # raise ArgumentError.new ("Withdrawal must be >=0") if amount < 0
      #
      # if @balance - amount - 1 < 0
      #   puts "This withdrawal would create a negative balance."
      #   @balance
      # else
      #   @balance = @balance - amount - 1
      # end
    end

    def withdraw_using_check(amount)
      raise ArgumentError.new ("Withdrawal must be >=0") if amount < 0

      if @checks_used < 4 && @balance - amount >= -10
        @checks_used += 1
        @balance = @balance - amount
      elsif @checks_used >= 4 && @balance - amount - 2 >= -10
        @checks_used += 1
        @balance = @balance - amount - 2
      else
        puts "This withdrawal would create an overdraft of more than -$10."
        @balance
      end

    end

    def reset_checks
      @checks_used = 0
    end

  end
end
