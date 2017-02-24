require 'csv'
require 'date'
require_relative 'owner'

module Bank
  class Account
    attr_reader :id, :balance , :open_date
    attr_accessor :owner

    @@all_accounts = []

    def initialize(id, balance, open_date='2010-12-21 12:21:12 -0800')
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      @id = id
      @balance = balance
      @open_date = open_date
      @@all_accounts << self
    end


    def self.reset_all_accounts_for_test
      @@all_accounts = []
    end


    def self.read_csv
      @@all_accounts = []
      CSV.open("./support/accounts.csv").each do |acct|
        acct_id = acct[0].to_i
        acct_balance_dollars = acct[1].to_i / 100.0
        acct_date = DateTime.parse(acct[2])
        self.new(acct_id,   acct_balance_dollars, acct_date)
      end
    end

    def self.all
      @@all_accounts
    end

    def self.find(id)
      found_accounts = @@all_accounts.select {|acct| acct.id == id}
      raise ArgumentError.new("That account doesn't exist!")  if found_accounts[0]==nil
      return found_accounts[0]
    end


    def withdraw(withdrawal_amount)
      raise ArgumentError.new("Withdrawal amount must be >= 0") if withdrawal_amount < 0
      if withdrawal_amount > @balance
        puts "You don't have enough in your account to withdraw that amount!"
      else @balance -= withdrawal_amount
      end
      return @balance
    end

    def deposit(deposit_amount)
      raise ArgumentError.new("Deposit amount must be >= 0") if deposit_amount < 0
      @balance += deposit_amount
    end

  end
end

#
# acct = Bank::Account.new(1212,1235667,'1999-03-27 11:30:09 -0800')
# Bank::Account.find(1212)
#
# puts acct.balance

# puts Bank::Account.reset_all_accounts_for_test
# puts Bank::Account.all

# puts acct.id

# puts acct.open_date

# acct.owner = Bank::Owner.new(name:"Janice Lichtman", address:"512A N 46th St, Seattle, WA", birthday:"May 16, 1974", pets_name: "Marshmallo")
#
# puts acct.owner
# puts acct.owner.birthday
