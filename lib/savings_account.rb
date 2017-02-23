module Bank

  class SavingsAccount < Account

    def initialize(id, balance, opendate = "nodate")
      super
      if balance < 10
        raise ArgumentError.new "You must initially deposit at least $10.00"
      end
    end

    def withdraw(withdrawal_amount)
      original_balance = @balance
      super(withdrawal_amount)

      if @balance == original_balance
        @balance
      elsif @balance - 2 <= 10
        puts "This withdrawal and fee will take your balance below $10."
        return @balance = original_balance
      else
        @balance -= 2
      end

    end

  end

end
