require_relative 'account'

module Bank

  class CheckingAccount < Bank::Account

    def withdraw(amount)

      raise ArgumentError.new ("Withdrawal must be >=0") if amount < 0

      if @balance - amount - 1 < 0
        puts "This withdrawal would create a negative balance."
        @balance
      else
        @balance = @balance - amount - 1
      end

    end

  end
end
