module Bank
  class Account
    attr_reader :id, :balance
    def initialize(id, balance)
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
    end

    def withdraw(amount)
      if @balance < amount
        it "Raises ArgumentError if account has a negative balance" do
          expect{ Bank.validate_arguments(nil) }.to raise_error(ArgumentError)
        end
      elsif @balance >= amount
        @balance = @balance - amount
      end
      return @balance
    end

    def deposit(amount)
      # if amount < 0
      #   .must_raise
      # end
      @balance = @balance + amount
      return @balance
    end
  end
end

# test_1 = Bank::Account.new(200, 50)
# test_1.withdraw(50)
