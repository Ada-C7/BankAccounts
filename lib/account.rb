module Bank
  class Account

    attr_reader :id, :balance
    def initialize(id, balance)
      if balance < 0
        raise ArgumentError.new "Can't be negative starting balance"
      else
        @id = id
      end
      @balance = balance
    end

    def withdraw(withdrawal_amount)
      if withdrawal_amount > @balance
        puts "You cannot withdraw more than you have in your account!"
        @balance = @balance
      elsif withdrawal_amount < 0
        raise ArgumentError.new "You cannot withdraw a negative amount."        
      else
        @balance -= withdrawal_amount
      end
    end


  end
end
