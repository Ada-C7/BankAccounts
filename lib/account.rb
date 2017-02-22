module Bank

  class Account

    attr_reader :id, :balance

    def initialize(id, balance)
      @id = id

      if balance > 0
        @balance = balance
      else
        raise ArgumentError.new "Account balance should not start with a negative number"

      end


    end

  end

end
