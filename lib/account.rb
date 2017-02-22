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
      # TODO: implement withdraw
      start_balance = @balance
      withdrawal_amount = amount
      if withdrawal_amount < 0
        raise ArgumentError.new 'You cannot withdraw a negative number'
      end

      if start_balance < withdrawal_amount
        raise ArgumentError.new 'Warning, account would go negative. Cannot withdraw.'
        withdrawal_amount = 0
      end

      @balance = start_balance - withdrawal_amount

      # if updated_balance < 0 then
      #   raise ArgumentError.new("Warning, your account would go negative.")
      #   updated_balance = start_balance
      # end
    end

    def deposit(amount)
      # TODO: implement deposit
      start_balance = @balance
      deposit_amount = amount
      if deposit_amount < 0
        raise ArgumentError.new 'You cannot deposit a negative number'
      end
      @balance = start_balance + deposit_amount
    end
  end
end
