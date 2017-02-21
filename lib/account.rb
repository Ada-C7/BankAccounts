# Bank module contains Account class and any future bank account logic.
module Bank
  class Account
    # allows access to the current balance of an account at any time.
    attr_accessor :account_balance
    # only allow reader on unique account id
    attr_reader :id

    # constructs a new Account object
    def initialize(id, initial_balance)
      # error handling for initial negative balance
      if initial_balance >= 0
        @account_balance = initial_balance
      else
        raise ArgumentError.new "Inital balance cannot be a negetive value"
      end
      @id = id

    end

    # method that handles withdraw
    def withdraw(money_amount)
      # error handling for insufficient funds for a withdraw
      if @account_balance >= money_amount
        @account_balance -= money_amount
      else
        raise ArgumentError.new "You do not have sufficient funds to withdraw the entered amount"
      end
      return @account_balance
    end

    # method that handles deposits
    def deposit(money_amount)
      @account_balance += money_amount
      return @account_balance
    end

  end
end
