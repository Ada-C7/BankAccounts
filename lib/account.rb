# require_relative 'owner'
require 'csv'
require 'date'

module Bank

  class Account
    # you are not using writer methods when you change @balance so can get away with an attr_reader
    # #the owner is going to be the owner object
    attr_reader :id, :balance, :owner, :opening_date

    def initialize(id, balance, date = '')
      @id = id
      unless balance >= 0
        raise ArgumentError.new "Balance must be greater or equal to 0"
      end
      @balance = balance
      @opening_date = date
    end

    def withdraw(withdrawal_amount)
      check_amount_is_over_zero(withdrawal_amount)
      if @balance - withdrawal_amount >= 0
        return @balance = @balance - withdrawal_amount
      else
        puts "Insufficient funds"
        return @balance
      end
    end

    def deposit(deposit_amount)
      check_amount_is_over_zero(deposit_amount)
      @balance = @balance + deposit_amount
    end

    def check_amount_is_over_zero(amount)
      raise ArgumentError.new "Amount must be greater than zero" unless amount >= 0
    end

    # below are the class methods...
    # will read in info from CSV file return an array of account instances
    def self.all(csv_file)
      accounts = CSV.read(csv_file)
      # change the id to an integer and the balance to a dollar floats
      accounts.map! do |account_info|
        account_info[0] = account_info[0].to_i
        account_info[1] = account_info[1].to_f / 100
        account_info[2] = DateTime.parse(account_info[2])
        self.new(account_info[0], account_info[1], account_info[2])
      end
      return accounts
    end

    def self.find(id, accounts)
      accounts.each do |account_info|
        return account_info if account_info.id == id
      end
      raise ArgumentError.new "Error - that account does not exist"
    end
  end
end
