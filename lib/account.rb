require 'csv'

module Bank
  class Account
    attr_reader :id
    attr_accessor :balance

    def initialize(id, balance)
      raise ArgumentError.new("balance must be >=0") if balance < 0
      @id = id
      @balance = balance

    end

    def withdraw(withdrawal_amount)
      raise ArgumentError.new ("Withdrawal must be >=0") if withdrawal_amount < 0

      if @balance - withdrawal_amount < 0
        puts "This withdrawal would create a negative balance."
        @balance
      else
        @balance -= withdrawal_amount
      end
    end

    def deposit(deposit_amount)
      raise ArgumentError.new ("Deposit must be >= 0.") if deposit_amount < 0

      @balance += deposit_amount
    end

    def self.all
      #returns a collection(array or hash) of Account instances based on data from CSV file
      all_accounts = CSV.open("support/accounts.csv")
      account_array = []

      all_accounts.each do |line|
        id = line[0].to_i
        balance = line[1].to_i
        # will need to add open_date = line[2]
        account_array << Account.new(id, balance)
      end
      return account_array
      # build hash where ID maps to array of other data?
      # each line: [ID(int), Balance(int), OpenDate(datetime)]
    end

    def self.find(id)
      # returns an instance of Account where value matches ID
      # error if called with ID that doesn't exist
    end

  end
end
