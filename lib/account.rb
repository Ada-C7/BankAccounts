module Bank
  class Account
    attr_reader :id, :balance

    def initialize(id, balance = 0)
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
    end
    def withdraw(amount)
      @balance = @balance - amount
      return @balance
    end
  end
end
