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

    def self.reset_all_accounts_for_test
      @@all_accounts = []
    end

    def self.read_csv
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

    def self.add_owners_to_all_accounts
      #self.reset_all_accounts_for_test
      #Bank::Owner.reset_all_owners_for_test
      self.read_csv
      Bank::Owner.read_csv

      account_owners_csv = CSV.open("./support/account_owners.csv")
      account_owners_csv.each {|pair|
        account_id = pair[0].to_i
        owner_id = pair[1].to_i
        account = self.find(account_id)
        account.owner = Bank::Owner.find(owner_id)
      }
    end
  end
end

Bank::Account.add_owners_to_all_accounts
Bank::Account.all.each {|acct|
  puts acct.owner.state

}
