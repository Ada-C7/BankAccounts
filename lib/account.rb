module Bank

  class Account

    attr_reader :id
    attr_accessor :withdrawal_amount, :balance

    def initialize(id, balance)
      @id = id

      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "Account balance should not start with a negative number"
      end

    end #end of initialize

    def withdraw(withdrawal_amount)

      if @balance > withdrawal_amount
        return @balance -= withdrawal_amount
      else
        raise ArgumentError.new "Your account is overdrawn"
      end

    end #end of withdraw method

  end #end of class

end #end of module
