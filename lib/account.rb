require 'csv'

module Bank
  class Account
    attr_reader :id, :balance
    def initialize(id, balance)
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      @id = id
      @balance = balance
      # @account_array = []
      #
      # @read_file = CSV.read('support/accounts.csv')
      #
      # @read_file.each do |line|
      #   @account_array << line
      # end
    end

    def withdraw(amount)
      raise ArgumentError.new("withdrawal amount must be >= 0") if amount < 0
      if amount > @balance
        raise ArgumentError.new("withdrawal amount must be > 0") if @balance < 0 #@balance < amount
        puts "Account would go negative."
      elsif amount <= @balance
        @balance = @balance - amount
      end
      return @balance
    end

    def deposit(amount)
      raise ArgumentError.new("deposit amount must be >= 0") if amount < 0
      @balance = @balance + amount
      return @balance
    end

    def self.all
      accounts_array = []

      read_file = CSV.read('support/accounts.csv')

      read_file.each do |line|
        id = line[0].to_i
        balance = line[1].to_i
        open_date = line[2]
        account = Bank::Account.new(id, balance)
        accounts_array << account
      end

      return accounts_array
    end

    # def self.find(id)
    # end

  end
end

# @read_file = CSV.read('support/accounts.csv')
#
# @read_file.each do |line|
#   account_array << line
# end
