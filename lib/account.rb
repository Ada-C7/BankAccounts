module Bank
  class Account
    attr_reader :id, :balance
    def initialize(id, balance)
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
    end

    def withdraw(amount)
      @balance = @balance - amount
      if @balance < 0
        it "Raises ArgumentError if account has a negative balance" do
          expect{ Bank.validate_arguments(nil) }.to raise_error(ArgumentError)
          proc {
            account.withdraw(withdrawal_amount)
          }.must_output "Something"
        end
      end
      return @balance
    end

    def deposit(amount)
      # TODO: implement deposit
    end
  end
end

test_1 = Bank::Account.new(200, 50)
test_1.withdraw(50)
