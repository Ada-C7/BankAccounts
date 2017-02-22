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

      if withdrawal_amount < 0
        raise ArgumentError.new "You cannot withdraw a negative amount"
      end

      if start_balance >= withdrawal_amount
        @balance = start_balance - withdrawal_amount
      else
       puts "Cannot withdraw more than is in the account"
      end
      return @balance
    end

    def deposit(deposit_amount)
      start_balance = @balance
      if deposit_amount >= 0
        @balance = start_balance + deposit_amount
        return @balance
      else
      raise ArgumentError.new "You must deposit an amount"
      end
    end


  end #end class Account
end #end module Bank
