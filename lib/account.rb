module Bank
  class Account
    attr_reader :id
    attr_accessor :balance

    def initialize(id, balance)
      @id = id

      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "The balance must not be negative."
      end
    end

    def withdraw(withdrawal_amount)
      @balance = @balance - withdrawal_amount
    end

  end
end
