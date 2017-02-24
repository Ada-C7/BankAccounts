module Bank
  class CheckingAccount < Account

    def initialize(account_info)
      super
      @checks_used = 0
    end

    def withdraw(amount)
      if amount + 1 > @balance
        puts "Insufficient funds."
        @balance
      else
        super
        @balance -= 1
      end
    end

    def withdraw_using_check(amount)
      fee = @checks_used < 3 ? 0 : 2

      if amount + fee > @balance + 10
        puts "Insufficient funds."
        @balance
      else
        @checks_used += 1
        @balance -= amount + fee
      end
    end

    def reset_checks
      @checks_used = 0
    end

  end
end
