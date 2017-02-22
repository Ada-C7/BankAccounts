require 'csv'

module Bank

  class Account
    attr_reader :id, :balance, :date, :owner

    def self.all
      all_accounts = []
      CSV.open("accounts.csv").each do | line |
        acct_data = {}
        acct_data[:id] = line[0].to_i
        acct_data[:balance] = line[1].to_f
        acct_data[:date] = line[2]
        all_accounts << Bank::Account.new(acct_data)
      end
      return all_accounts
    end

    def self.find(id)
    end

    def initialize(acct_data, owner = "Customer Name")
      raise ArgumentError.new("You cannot create a bank account with a negative balance, you goober.") if acct_data[:balance] >= 0
      @idea = acct_data[:id]
      @date = acct_data[:date]
      @balance = acct_data[:balance]
      @owner = owner
    end

    def withdraw(withdrawal_amount)
      raise ArgumentError.new("You cannot withdraw a negative amount of money, you silly pants.") if withdrawal_amount < 0
      # if withdrawal_amount > 0
        if withdrawal_amount > @balance
          print "Uh oh! You can't overdraw your account, you doof!"
        else
          return @balance -= withdrawal_amount
        end
        return @balance
      # else
      #   raise ArgumentError.new "You cannot withdraw a negative amount of money, you silly pants."
      # end
    end

    def deposit(deposit_amount)
      raise ArgumentError.new("You cannot deposit a negative amount of money, you goofball.") if deposit_amount < 0
      # if deposit_amount > 0
        @balance += deposit_amount
      # else
        # raise ArgumentError.new "You cannot deposit a negative amount of money, you goofball."
    end

  end

end
