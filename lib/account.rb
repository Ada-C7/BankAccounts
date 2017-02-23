require 'CSV'

module Bank

  class Account
    attr_accessor :id, :balance, :open_date

    # creates a new account with an ID and an initial balance
    def initialize(id, balance, open_date)

      @id = id

      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "Your balance must be greater than 0."
      end

      @open_date = open_date

    end

    # creates a withdraw method that accepts a single parameter
    # which represents the amount of money that will be withdrawn.
    # and returns the updated account balance.
    def withdraw(withdrawal_amount)
      if withdrawal_amount >= 0
        if withdrawal_amount <= @balance
          @balance -= withdrawal_amount
        else
          print "Insufficent funds."
        end
      else
        raise ArgumentError.new "Your withdrawal amount must be greater than 0."
      end

      return @balance
    end

    # creates a deposit method that accepts a single parameter
    # which represents the amount of money that will be deposited
    # and returns the updated account balance.
    def deposit(deposit_amount)
      if deposit_amount >= 0
        @balance += deposit_amount
      else
        raise ArgumentError.new "Your deposit amount must be greater than 0."
      end

      return @balance
    end

    # Allows the  Account class to handle all of the
    # fields from the "accounts.csv" file used as input.
    # returns a collection of Account instances, representing
    # all of the Accounts described in the CSV. See below for
    # the CSV file specifications.
    def self.all
      accounts = []

      CSV.open("../support/accounts.csv").each do |account|
        new_account = Account.new(account[0].to_f, account[1].to_f, account[2])
        accounts.push(new_account)
      end

      accounts
    end

    # returns an instance of Account where the value of the id
    # field in the CSV matches the passed parameter.
    # Question: what should your program do if Account.find
    # is called with an ID that doesn't exist?
    def self.find(id)
    end


    # creates a check_balance method to access
    # the current balance of an account at any time.
    def check_balance
    end
  end

  class Owner
  attr_accessor :first_name, :last_name, :address

    def initialize(first_name, last_name, address)
      @first_name = first_name
      @last_name = last_name
      @address = address
    end
  end

end

puts all_accounts = Bank::Account.all
