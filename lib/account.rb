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
      @balance -= withdrawal_amount
      if @balance < 0
        puts "Warning, the balance cannot be negative"
      end
      return @balance
    end

    def deposit
    end
  end
end
