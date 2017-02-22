module Bank
  class Account
    attr_reader :id, :balance
    def initialize(id, balance)
      @id = id
      @balance = balance
      if @balance < 0
        raise ArgumentError.new "The starting balance cannot be negative"
      end
    end

    def withdraw(withdrawal_amount)
      if withdrawal_amount > @balance
        puts "Warning, the balance cannot be negative"
        @balance = @balance
      elsif withdrawal_amount < 0
        raise ArgumentError.new "You cannot withdraw a negative amount"
      else
        @balance -= withdrawal_amount
      end
    end

    def deposit
    end
  end
end
