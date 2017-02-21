module Bank
  class Account
    attr_reader :id
    attr_accessor :balance

    def initialize(id, balance)
      @id = id

      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "The balance must not be negative."
      end
    end

    def withdraw(withdrawal_amount)
      if withdrawal_amount < 0
        raise ArgumentError.new "The withdrawal amount must have a positive value."
      end

      if @balance - withdrawal_amount < 0
        puts "This withdrawal would create a negative balance."
        @balance
      else
        @balance = @balance - withdrawal_amount
      end
    end

  end
end

# account = Bank::Account.new(004, 100)
# puts account.balance
# account.withdraw(30)
# puts account.balance
# account.withdraw(100)
