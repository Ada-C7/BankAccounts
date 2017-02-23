module Bank
  class SavingsAccount < Account
    def initialize(id, start_balance)
      super(id, start_balance)

      if start_balance >= 10.0
        @balance = start_balance
      else raise ArgumentError.new
      end
    end
  end
end
