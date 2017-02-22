module Bank
  class Account
    attr_reader :id, :balance
    def initialize(id, balance)
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
    end

    def withdraw(amount)
      # TODO: implement withdraw
    end

    def deposit(amount)
      # TODO: implement deposit
    end
  end
end
