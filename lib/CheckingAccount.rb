require_relative '../lib/account_wave_2'

module Bank

  class CheckingAccount < Account

    def initialize(id, initial_deposit)
      raise ArgumentError if initial_deposit < 10
      @initial_deposit = initial_deposit
      @balance = @initial_deposit
      @id = id
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
    end

    def reset_checks
    end

  end

end
