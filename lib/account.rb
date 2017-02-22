# Bank module contains Account class and any future bank account logic.
module Bank
  class Account
    # allows access to the current balance of an account at any time.
    attr_accessor :balance, :owner
    # only allow reader on unique account id
    attr_reader :id

    # constructs a new Account object
    # give a default value, in case the Owner class object is not passed
    def initialize id, initial_balance, owner = nil
      # error handling for initial negative balance
      if initial_balance >= 0
        @balance = initial_balance
      else
        raise ArgumentError.new "Inital balance cannot be a negetive value"
      end
      @id = id

      #note: in the future, consider account holder with multiple accounts
      if owner.class == Bank::Owner
        @owner = owner
      else
        @owner = Bank::Owner.new({})
      end
    end

    # method that overwrites existing empty @owner instance variable
    def update_owner_data(owner_hash)
      #only overwrite if initially not added to account at the time of initializing account object
      #note: in the future, consider being able to update names, addess, phone numbers
      #      individually for existing @owner
      if @owner.customer_id == "0000"
        @owner = Bank::Owner.new(owner_hash)
      end
    end

    # method that handles withdraw
    def withdraw(money_amount)
      # error handling for insufficient funds for a withdraw
      if @balance < money_amount
        puts "You do not have sufficient funds to withdraw the entered amount"
      elsif money_amount < 0
        raise ArgumentError.new "Withdraw amount cannot be a negetive value"
      else
        @balance -= money_amount
      end
      return @balance
    end

    # method that handles deposits
    def deposit(money_amount)
      if money_amount < 0
        raise ArgumentError.new "Deposit amount cannot be a negetive value"
      else
        @balance += money_amount
        return @balance
      end
    end
  end
end
