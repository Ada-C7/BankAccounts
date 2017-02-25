module Bank
  class CheckingAccount < Account
    #attr_reader :check_count
    def initialize(id, initial_balance, open_date = 0, owner_id = -1)
      super
      @checks_processed = 0
    end

    def withdraw(amount)
      withdrawal_fee = 1.0
      if (@balance - amount - withdrawal_fee) > 0
        @balance -= (amount + withdrawal_fee)
      else
        puts "Insufficient funds, balance would go negative."
      end
      return @balance
    end

    def withdraw_using_check(amount)
      raise ArgumentError.new "Invalid negative amount" if amount < 0
      max_overdraft = -10
      # $2 check fee per check after 3 checks
      # in ONE month
      if @checks_processed <= 3
        check_fee = 0.0
      else
        check_fee = 2.0
      end

      if (@balance - amount - check_fee) >= max_overdraft
        @balance -= (amount + check_fee)
        @checks_processed += 1
      else
        print "Check ($#{amount}) would make your account go below -$10."
      end
      return @balance
    end

  end

end
