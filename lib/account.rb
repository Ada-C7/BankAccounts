module Bank
  class Account
    attr_reader :id, :balance
    def initialize(id, balance)
      #error message not appearing in def withdraw
      #WOW, that balance can't be @balance. WHY?
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
    end

    def withdraw(amount)
      start_balance = @balance
      withdrawal_amount = amount
      if withdrawal_amount < 0
        raise ArgumentError.new 'You cannot withdraw a negative number'
      end
      if withdrawal_amount > start_balance
        puts 'Warning, account would go negative. Cannot withdraw.'
        withdrawal_amount = 0
      end
      @balance = start_balance - withdrawal_amount
    end

    def deposit(amount)
      start_balance = @balance
      deposit_amount = amount
      if deposit_amount < 0
        raise ArgumentError.new 'You cannot deposit a negative number'
      end
      @balance = start_balance + deposit_amount
    end
  end
end
