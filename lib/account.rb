require 'csv'
require 'date'

module Bank
  class Account
    # Allows access to the current balance of an account at any time.
    attr_accessor :balance, :owner
    # Only allow reader on unique account id, and opendate
    attr_reader :id, :open_date

    # Constructs a new Account object
    # Give a default value, in case the Owner class object is not passed
    # Assumes passed parameters are formated in their correct data type.
    def initialize id, balance, open_date, owner = nil
      # error handling for initial negative balance
      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "Inital balance cannot be a negetive value"
      end

      @id = id
      @open_date = DateTime.parse(open_date)

      # Assumes that required csv file is accesible
      CSV.read("support/account_owners.csv").each do |line|
        if line[0].to_i == @id
          @owner = Bank::Owner.find(line[1].to_i)
        end
      end

      if owner.class == Bank::Owner
        @owner = owner
      else
        # Default instance of the Owner class initialized with empty hash
        @owner = Bank::Owner.new({})
      end
    end

    # Method that returns a collection of Account instances, from data read in CSV
    def self.all
      all_accounts_array= []

      CSV.read("support/accounts.csv").each do |line|
        all_accounts_array << Bank::Account.new( line[0].to_i, line[1].to_i, line[2] )
      end
      return all_accounts_array
    end

    # Method that returns an instance of an Account class, where the value of the id field in the CSV matches the passed parameter
    def self.find(id)
      raise ArgumentError.new ("Account id must be a positive integer value") if ( id.class != Integer || id < 1 )

      CSV.read("support/accounts.csv").each do |line|
        if line[0].to_i == id
          account = Bank::Account.new( line[0].to_i, line[1].to_i, line[2])
          return account
        end
      end
      raise ArgumentError.new "Account id does not exist in the database"
    end


    # Method that overwrites existing empty @owner instance variable
    def update_owner_data(owner_hash)
      # Only overwrite if initially not added to account at the time of initializing account object
      if @owner.id == 0
        @owner = Bank::Owner.new(owner_hash)
      end
    end

    # Method that handles withdraw
    def withdraw(withdraw_amount)
      # Error handling for insufficient funds for a withdraw
      raise ArgumentError.new ("Withdraw amount must be a positive numericla value") if ( !(withdraw_amount.class == Integer || withdraw_amount.class == Float) || withdraw_amount < 0 )
      # Insufficient funds
      if @balance < withdraw_amount
        puts "You do not have sufficient funds to withdraw the entered amount"
      # Negative withdraw amount, invalid
    elsif withdraw_amount < 0
        raise ArgumentError.new "Withdraw amount cannot be a negetive value"
      # Allow withdraw and update the balance
      else
        @balance -= withdraw_amount
      end
      return @balance
    end

    # Method that handles deposits
    def deposit(money_amount)
      # Negative deposit amount, invalid
      if money_amount < 0
        raise ArgumentError.new "Deposit amount cannot be a negetive value"
      else
        @balance += money_amount
        return @balance
      end
    end
  end
end
