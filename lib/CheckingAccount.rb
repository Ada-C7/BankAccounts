require_relative '../lib/account_wave_2'

module Bank

  class CheckingAccount < Account

    attr_reader :balance, :checks_used, :check_fee, :withdraw_fee
    def initialize(id, initial_deposit)
      raise ArgumentError if initial_deposit < 10
      @balance = initial_deposit
      @id = id
      @checks_used = 0
      @check_fee = 0
      @withdraw_fee = 1
    end

    def withdraw(amount)
      if @balance - (@withdraw_fee + amount) < 0 || @balance - amount < 0
        puts "Can't go negative!"
      else
        @balance -= @withdraw_fee
        super
      end
      return @balance
    end

    def withdraw_using_check(amount)
      if @checks_used >= 3
        @check_fee = 2
      end
      if amount < 0
        puts "can't withdraw a negative amount"
        return
      end
      # total_amount = amount + @fee
      if @balance - (amount + @check_fee) < -10
        puts "Can't go less than -10!"
        return
      else
        @balance -= (amount + @check_fee)
        @checks_used += 1
      end
      return @balance
    end

    def reset_checks
      @checks_used = 0
      @check_fee = 0
    end

  end

end
