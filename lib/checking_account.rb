require_relative 'account'

module Bank
  class CheckingAccount < Account

    def initialize(id, balance)
      super(id, balance)
      @number_of_checks = 0
    end

    def withdraw(amount) #I'm doing something with super. So just copied the whole thing.
      start_balance = @balance
      withdrawal_amount = amount
      fee = 1
      if withdrawal_amount < 0
        raise ArgumentError.new 'You cannot withdraw a negative number'
      end
      if withdrawal_amount > start_balance
        puts 'Warning, account would go negative. Cannot withdraw.'
        withdrawal_amount = 0
      end
      if withdrawal_amount + fee > start_balance
        puts 'Warning, account would go negative. Cannot withdraw.'
        withdrawal_amount = 0
        fee = 0
      end
      @balance = start_balance - withdrawal_amount - fee
    end

    def withdraw_using_check(amount)
      start_balance = @balance
      withdrawal_amount = amount
      if withdrawal_amount < (-10)
        raise ArgumentError.new 'You cannot withdraw more than -$10'
      end
      @balance = start_balance - withdrawal_amount

      @number_of_checks += 1

      if @number_of_checks > 3
        @balance = start_balance - withdrawal_amount - 2
      end
    end

    def reset_checks
      @number_of_checks = 0
    end

  end
end
