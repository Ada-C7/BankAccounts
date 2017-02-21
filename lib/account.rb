# Create a class inside of a module
# Create methods inside the class to perform actions
# Learn how Ruby does error handling
# Verify code correctness by testing


module Bank
  class Account
    attr_accessor :id, :balance

    def initialize(id, balance)
      @id = id

      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "The balance cannot be negative"
      end
    end

    def withdraw(withdrawal_amount)
      start_balance = @balance
      @balance = start_balance - withdrawal_amount
    end

  end #end class Account
end #end module Bank
