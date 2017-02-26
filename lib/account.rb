require 'csv'

module Bank
  class Account
    attr_reader :id, :balance, :open_date, :count
    @@all_accounts = []

    def initialize(id, balance, open_date = '2012 - 12-21 12:21:12 -0800')
      @id = id
      @balance = balance
      raise ArgumentError, "You cannot have a negative balance" unless balance >= 0
      @open_date = open_date
      # @@all_accounts << self
    end

    def self.all
      @@all_accounts ||= read_csv
    end

    def self.read_csv
      @@all_accounts = []
      CSV.open("./support/accounts.csv").each do |account|
        @@all_accounts << self.new(account[0].to_i, account[1].to_f, account[2].to_s)
      end
    end

    def self.find(id_no)
      found_account = ""
      @@all_accounts.each do |account|
        if account.id == id_no
          found_account = account
          # return found_account
        end
      end
      raise ArgumentError.new("You must select a valid account") if found_account == ""
      return found_account
    end

    # found_accounts = @@all_accounts.select {|acct| acct.id == id}

    def withdraw(amount)
      raise ArgumentError, "Withdrawals should be a positive number" unless amount >=0
      if amount <= @balance
        @balance = @balance - amount
      else
        puts "You do not have enough money in your account."
        @balance
      end
    end

    def deposit(amount)
      raise ArgumentError, "Deposits should be a positive number" unless amount >=0
      @balance = @balance + amount
    end
  end
end
# class Owner(name, address)
#   attr_reader :name, :address
#
#   def initialize
#     @name = name
#     @address = address
#   end
#
#   def add_owner(id)
#
#   end
# end


Bank::Account.read_csv
# puts Bank::Account.all.id
# puts Bank::Account.find()
