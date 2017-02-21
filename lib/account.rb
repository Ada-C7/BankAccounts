module Bank

  class Account
    attr_reader :id
    attr_accessor :balance

    def initialize(id, balance)
      @id = id
      if balance >= 0
      @balance = balance
      else
        raise ArgumentError.new "The balance must be 0 or above"
      end
    end

    def withdraw(withdrawal)
      if (@balance - withdrawal < 0)
        print "Warning! Withdrawing this amount will put your
        balance in the negative"
      end
      @balance = @balance - withdrawal
    end

  end


end
