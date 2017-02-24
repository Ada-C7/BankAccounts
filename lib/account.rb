require 'csv'

module Bank
  class Account
    attr_reader :id
    attr_accessor :balance, :withdrawal_fee, :balance_limit

    def initialize(id, balance)
      raise ArgumentError.new("balance must be >=0") if balance < 0
      @id = id
      @balance = balance
      @withdrawal_fee = 0
      @balance_limit = 0
    end

    def withdraw(withdrawal_amount)
      raise ArgumentError.new ("Withdrawal must be >=0") if withdrawal_amount < 0

      if @balance - withdrawal_amount - withdrawal_fee < balance_limit
        puts "This withdrawal would create a balance below #{balance_limit}."
        @balance
      else
        @balance = @balance - withdrawal_amount - withdrawal_fee
      end
    end

    def deposit(deposit_amount)
      raise ArgumentError.new ("Deposit must be >= 0.") if deposit_amount < 0

      @balance += deposit_amount
    end

    def self.all
      #returns a collection of Account instances based on data from CSV file
      all_accounts = CSV.open("support/accounts.csv")
      account_array = []

      all_accounts.each do |line|
        id = line[0].to_i
        balance = line[1].to_i
        # will need to add open_date = line[2]
        account_array << Account.new(id, balance)
        # could store in class variable to make available to self.find
      end
      return account_array
      # build hash where ID maps to array of other data?
      # each line: [ID(int), Balance(int), OpenDate(datetime)]
    end

    def self.find(required_id)
      # returns an instance of Account where value matches ID
      # error if called with ID that doesn't exist
      account_array = Account.all

      account_array.each do |account|
         if account.id == required_id
           return account
         end
      end

      raise ArgumentError.new ("No account exists with that ID.")

    end

  end
end
