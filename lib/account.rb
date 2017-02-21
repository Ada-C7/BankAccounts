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
      @balance = @balance - withdrawal
    end

  end


end
