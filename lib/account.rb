require 'csv'
require 'date'

module Bank
  # Account responsibility: mainitain the balance
  class Account
    attr_reader :id, :balance, :owner, :opening_date

    # takes in 3 arguments, sets the id, balance, and opening date
    def initialize(id, balance, date = '')
      unless balance >= 0
        raise ArgumentError.new "Balance must be greater or equal to 0"
      end
      @id = id
      @balance = balance
      @opening_date = date
    end

    # methods should do one type of thing: subtract the withdrawal amount from balance
    # its running application logic (check amount > 0 and if else) and its rewriting balance
    # checking that withdrawal amount is greater than zero and wont return a negative balance
    def withdraw(withdrawal_amount)
      check_amount_is_over_zero(withdrawal_amount)
      return "Insufficient funds" if @balance - withdrawal_amount < 0
      @balance = @balance - withdrawal_amount
    end

    def deposit(deposit_amount)
      check_amount_is_over_zero(deposit_amount)
      @balance = @balance + deposit_amount
    end

    def check_amount_is_over_zero(amount)
      raise ArgumentError.new "Amount must be greater than zero" unless amount >= 0
    end

    # below are the class methods
    # will read in info from CSV file return an array of account instances
    def self.all(csv_file)
      accounts = CSV.read(csv_file)
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
