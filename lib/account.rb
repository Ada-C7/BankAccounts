require 'CSV'

module Bank

  class Account
    attr_accessor :id, :balance, :open_date

    # creates a new account with an ID and an initial balance
    def initialize(id, balance, open_date = nil )

      raise ArgumentError.new "Your balance must be greater than 0." if balance < 0
      @balance = balance
      @id = id
      @open_date = open_date
    end

    # Allows the  Account class to handle all of the
    # fields from the "accounts.csv" file used as input.
    # returns a collection of Account instances, representing
    # all of the Accounts described in the CSV. See below for
    # the CSV file specifications.
    def self.all

      accounts = []

      CSV.open("support/accounts.csv").each do |account|
        id = account[0].to_i
        balance = account[1].to_i
        open_date = account[2]

        new_account = Account.new(id, balance, open_date)
        accounts << new_account
      end

      return accounts
    end

    # returns an instance of Account where the value of the id
    # field in the CSV matches the passed parameter.
    # Question: what should your program do if Account.find
    # is called with an ID that doesn't exist?
    def self.find(id)

      accounts = Bank::Account.all

      accounts.each do |account|
        if account.id == id
          return account
        end
      end

      raise ArgumentError.new "That Account ID doesn't exist"
    end

    # creates a withdraw method that accepts a single parameter
    # which represents the amount of money that will be withdrawn.
    # and returns the updated account balance.
    def withdraw(amount)

      raise ArgumentError.new "Your withdrawal amount must be greater than 0." if amount <= 0

      if amount > @balance
        puts "Insufficent funds"
      else
        @balance -= amount
      end

      return @balance
    end

    # creates a deposit method that accepts a single parameter
    # which represents the amount of money that will be deposited
    # and returns the updated account balance.
    def deposit(deposit_amount)

      raise ArgumentError.new "Your deposit amount must be greater than 0." if deposit_amount <= 0

      @balance += deposit_amount
    end

    # creates a check_balance method to access
    # the current balance of an account at any time.
    def check_balance
      return @balance
    end
  end
end



  # class Owner
  # attr_accessor :first_name, :last_name, :address
  #
  #   def initialize(first_name, last_name, address)
  #     @first_name = first_name
  #     @last_name = last_name
  #     @address = address
  #   end
  # end
