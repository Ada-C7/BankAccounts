require 'csv'

module Bank
  class Account

    attr_reader :balance, :id, :date

    def self.all
      new_account_info = []
      accounts_master = CSV.read("../support/accounts.csv")
      accounts_master.each do |account_array|
        id = account_array[0].to_i
        balance = account_array[1].to_i
        date = account_array[2].to_i
        new_account_info << Account.new(id, balance, date)
        #  end_with_object(self).to_a
      end
      return new_account_info
    end

    #self.all.count

    def initialize(id, balance, date) #deposit)
      if balance < 0
        raise ArgumentError.new "You can only open a new account with real money:)"
      else
        @balance = balance
        @id = id
      end
    end

    def new_account(balance)
      if @new_account >= 0
        @new_account  #Account.new(balance)
      else
        raise ArgumentError.new "You can only open a new account with real money:)"
      end
    end

    def withdraw(amount_to_withdraw)
      if amount_to_withdraw > @balance
        puts "Insufficient funds. Your balance is #{@balance}"
        raise ArgumentError.new("amount must be >= 0") if amount < 0
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
