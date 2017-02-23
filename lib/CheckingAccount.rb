require_relative '../lib/account_wave_2'

module Bank

  class CheckingAccount < Account

    attr_reader :balance, :checks_used
    def initialize(id, initial_deposit)
      raise ArgumentError if initial_deposit < 10
      @balance = initial_deposit
      @id = id
      @checks_used = 0
    end

    def withdraw(amount)
      fee = 1
      if @balance - (fee + amount) < 0 || @balance - amount < 0
        puts "Can't go negative!"
      else
        @balance -= fee
        super
      end
      return @balance
    end

    def withdraw_using_check(amount)
      if @checks_used < 4 ? fee = 0 : fee = 2
      if @balance - (amount + fee) < -10
        puts "Can't go less than -10!"
        return
      else
        @balance -= (fee + amount)
      end
      @checks_used += 1
      return @balance
    end

    def reset_checks
      @checks_used = 0
    end

  end

end
