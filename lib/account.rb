require 'csv'

module Bank
  class Account

    attr_reader :balance, :id, :open_date 
#can self.all be refactored if for no other reason than my understanding
    def self.all
      new_account_info = []
      accounts_master = CSV.read("../support/accounts.csv")
      accounts_master.each do |account_array|
        id = account_array[0].to_i
        balance = account_array[1].to_i
        date = account_array[2]
        new_account_info << Account.new(id, balance, date)
        #  end_with_object(self).to_a
        opening_balance = 0
      end
      return new_account_info
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

    def initialize(id, balance, open_date = nil)
      raise ArgumentError.new "Balance must be positive or 0" unless balance >= 0
      @id = id
      @balance = balance
      @open_date = open_date
    end
#redundant as @min_balance in savings account - i think it is being overridden by min balance
    def opening_balance(balance)
      if @opening_balance >= 0
        @opening_balance
      else
        raise ArgumentError.new "You can only open a new account with real money:)"
      end
    end

    def withdraw(amount_to_withdraw)
      if amount_to_withdraw > @balance
        puts "Insufficient funds. Your balance is #{@balance}"
      elsif amount_to_withdraw < 0
        raise ArgumentError.new "amount must be >= 0"
        # start_balance = @balance
        # @balance = start_balance
      else
        # start_balance = @balance
        @balance -= amount_to_withdraw
      end
      return @balance
    end

    def deposit(amount_to_deposit)
      if amount_to_deposit < 0
        raise ArgumentError.new "You must deposit real money."
      else
        @balance += amount_to_deposit
      end
    end
  end
end

#Sself.find(id) #- returns an instance of Account where the value of the id field in the CSV matches the passed parameter.
