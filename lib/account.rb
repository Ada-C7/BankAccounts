# Create a Bank module which will contain your Account class and any future bank account logic.
# Create an Account class which should have the following functionality:
module Bank

  class Account
    attr_reader :id
    attr_accessor :balance

    def initialize(id, balance)
      @id = id
      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "You cannot create a bank account with a negative balance."
      end
    end

    def withdraw(withdrawal_amount)
      @balance -= withdrawal_amount
    end

  end

end
# A new account should be created with an ID and an initial balance
# Should have a withdraw method that accepts a single parameter which represents the amount of money that will be withdrawn. This method should return the updated account balance.
# Should have a deposit method that accepts a single parameter which represents the amount of money that will be deposited. This method should return the updated account balance.
# Should be able to access the current balance of an account at any time.

# Error handling
# A new account cannot be created with initial negative balance - this will raise an ArgumentError (Google this)
# The withdraw method does not allow the account to go negative. Instead it will output a warning message and return the original un-modified balance.

# Optional:
# Make sure to write tests for any optionals you implement!
# Create an Owner class which will store information about those who own the Accounts.
# This should have info like name and address and any other identifying information that an account owner would have.
# Add an owner property to each Account to track information about who owns the account.
# The Account can be created with an owner, OR you can create a method that will add the owner after the Account has already been created.
