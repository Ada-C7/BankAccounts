require 'csv'

module Bank
  class Account
    attr_reader :id, :balance, :open_date

    def initialize(id, balance, open_date = nil)

      raise ArgumentError.new("balance must be >= 0") if balance < 0
      @id = id
      @balance = balance
      @open_date = open_date
    end

    def self.all #better name! .create_all_accounts_from_csv
      #.all is JUST the class method name. Like the instance method names
      accounts = []

      CSV.read("support/accounts.csv").each do |line|
        id = line[0].to_i
        balance = line[1].to_i
        open_date = line[2]

        account_instance = Bank::Account.new(id, balance, open_date)

        accounts << account_instance
      end

      accounts
    end

    def self.find(id)
      accounts = Bank::Account.all

      accounts.each do |account|
        if account.id == id
          return account
        end
      end

      raise ArgumentError.new "Account: #{id} does not exist"
    end

    def withdraw(amount)
      start_balance = @balance
      withdrawal_amount = amount
      if withdrawal_amount < 0
        raise ArgumentError.new 'You cannot withdraw a negative number'
      end
      if withdrawal_amount > start_balance
        puts 'Warning, account would go negative. Cannot withdraw.'
        withdrawal_amount = 0
      end
      @balance = start_balance - withdrawal_amount
    end

    def deposit(amount)
      start_balance = @balance
      deposit_amount = amount
      if deposit_amount < 0
        raise ArgumentError.new 'You cannot deposit a negative number'
      end
      @balance = start_balance + deposit_amount
    end
  end
end
