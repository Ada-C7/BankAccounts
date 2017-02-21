module Bank
  class Account
    attr_reader :id, :balance

    def initialize(id, balance)
      @id = id
      @balance = balance
    end

  end
end
