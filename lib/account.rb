module Bank
  class Account
    attr_reader :id, :balance

    def initialize(id, balance)
      @id = id
      if balance.abs == balance
        @balance = balance
      else
        raise ArgumentError.new "Balance cannot be negative"
      end
    end

  end
end
