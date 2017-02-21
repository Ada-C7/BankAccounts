module Bank

  class Account

@@id = 1336
    attr_reader :id, :balance

    def initialize(id, balance)
      @id = @@id +=1
      @balance = balance
    end

  end

end
