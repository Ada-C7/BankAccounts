module Bank

  class Account
    attr_reader :id, :balance

    def initialize(id, balance)
      @id = id

      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "The value must be between greater than or equal to 0"
      end
    end

    # def withdraw(amount_withdrawn)
    #
    # end

  end

end
