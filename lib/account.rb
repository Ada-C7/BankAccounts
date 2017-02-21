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

    


  end
end
