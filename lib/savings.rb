require_relative '../lib/account'

module Bank
  class SavingsAccount < Bank::Account
    attr_reader :id, :balance, :open_date

    def initialize(id, balance, open_date = nil)

      raise ArgumentError.new("balance must be atleast $10") if balance < 1000 #balance is in cents
      @id = id
      @balance = balance
      @open_date = open_date
    end

    def withdraw(amount)
      start_balance = @balance
      withdrawal_amount = amount
      if withdrawal_amount < 0
        raise ArgumentError.new 'You cannot withdraw a negative number'
      end
      if withdrawal_amount > 1000
        puts 'Warning, account would go below $10. Cannot withdraw.'
        withdrawal_amount = 0
      end
      @balance = start_balance - withdrawal_amount - 200
    end

    def add_interest(rate)
      if rate < 0
        raise ArgumentError.new 'Interest rate cannot be a negative number'
      end
      @balance = @balance * (rate/100)
    end
  end
end
