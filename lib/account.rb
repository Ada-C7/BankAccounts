require 'csv'

module Bank

  class Account
    attr_reader :id, :balance, :open_date, :withdrawal_fee

    ARRAY_OF_ACCOUNTS = []

    def initialize(id, balance, open_date = nil, withdrawal_fee = 0) # method to initialize and accept two parameters...ID and starting balance
      @id = id
      @withdrawal_fee = withdrawal_fee
      @open_date = open_date
      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "Please enter a positive integer."
      end
    end

    def withdraw(withdrawal_amount) # method subtracts withdrawal amt from bal and return the updated bal

      if withdrawal_amount < 0
        raise ArgumentError.new "Please enter a positive integer."
      end

      if (withdrawal_amount + @withdrawal_fee) > balance
        print "Tried to withdraw #{ withdrawal_amount } when you only have #{ balance }." # needed to output something instead of raising an error
        return balance
      else
        bal_after_withdrawal = balance - withdrawal_amount - @withdrawal_fee
        @balance = bal_after_withdrawal
        return balance
      end
    end

    def deposit(deposit_amount) # method adds deposit amt to bal and return the updated bal
      bal_after_deposit = balance + deposit_amount

      if deposit_amount < 0
        raise ArgumentError.new "Please enter a positive integer."
      else
        @balance = bal_after_deposit
      end
      return balance
    end

    def balance_inquiry # method needs to let user access balance at any time
      puts @balance
    end

    def self.all

      if ARRAY_OF_ACCOUNTS.empty? # This allows us to start with a blank slate so that each time we run .all we aren't just appending to the array

        csv_data = CSV.read("support/accounts.csv")

        csv_data.each do |line|
          ARRAY_OF_ACCOUNTS << Account.new(line[0].to_i, line[1].to_i, line[2])
        end
      end
      return ARRAY_OF_ACCOUNTS
    end

    def self.find(id)
      Bank::Account.all
      
      ARRAY_OF_ACCOUNTS.each do |account|
        if account.id == id
          return account
        end # end of the if stmt
      end # end of the each loop
      raise ArgumentError.new "Account doesn't exist."
    end
  end
end
