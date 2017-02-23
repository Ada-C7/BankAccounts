# require_relative 'owner'
require 'csv'
module Bank

  class Account
    # you are not using writer methods when you change @balance so can get away with an attr_reader
    # #the owner is going to be the owner object
    attr_reader :id, :balance, :owner, :opening_date

    def initialize(id, balance, date)
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
        @balance = @balance - withdrawal_amount
      else
        # figure out how to send this to a printer class...
        puts "Insufficient funds"
      end
      @balance
    end

    def deposit(deposit_amount)
      check_amount_is_over_zero(deposit_amount)
      @balance = @balance + deposit_amount
    end

    def check_amount_is_over_zero(amount)
      unless amount >= 0
        raise ArgumentError.new "Amount must be greater than zero"
      end
    end

    # will read in info from CSV file return an array of account objects
    def self.all(csv_file)
      @accounts = CSV.read(csv_file)
      # change the id to an integer and the balance to a dollar floats
      @accounts.each do |info_array|
        info_array[0] = info_array[0].to_i
        info_array[1] = info_array[1].to_f / 100
      end

      #initiate the accounts using self.new
      @accounts.map! do |account_info|
        # Account.new(id, balance, date)
        self.new(account_info[0], account_info[1], account_info[2])
      end
      return @accounts
    end

    def self.find(id)
      @accounts.each do |account_info|
        return account_info if account_info.id == id
      end
      raise ArgumentError.new "Error - that account does not exist"
    end
  end
end
