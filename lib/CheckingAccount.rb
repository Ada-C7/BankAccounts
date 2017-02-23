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
      fee = 2
      puts "Can't go less than -10!" if @balance - amount < -10
      if @checks_used > 3
        puts "Can't go less than -10" if @balance - (fee + amount) < -10 
        @balance -= (fee + amount)
      else
        @balance -= amount
      end
      @checks_used += 1
      return @balance
    end

    def reset_checks
      @checks_used = 0
    end

  end

end
