require 'csv'

module Bank

  class Account
    attr_accessor :balance
    attr_reader :id , :datetime, :owner

    def initialize(id, balance, datetime=nil)
      @id = id
      @datetime = datetime

      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "The value must be between greater than or equal to 0"
      end
    end

    def self.all

      accounts_array = []
      CSV.read("support/accounts.csv").each do |account_info|
        create_new_accounts = Bank::Account.new(account_info[0].to_f, account_info[1].to_f, account_info[2])
        accounts_array.push(create_new_accounts)
      end

      accounts_array

    end

#A class variable could be used here
    def self.find(id)
      #accounts_array.include?(Account.find(id))
      #return Account.new(id)
      answer = nil

      find_accounts = Bank::Account.all
      find_accounts.each do |account|
        if account.id == id
          answer = account
        end
      end

      raise ArgumentError.new "Warning: Acount #{id} does not exist." if answer == nil

      return answer

    end

    def withdraw(withdrawal_amount)

      if withdrawal_amount > @balance
        puts "Warning! You are about to withdraw more money than you have in your account."
        #withdrawal_amount = 0
        @balance
      elsif withdrawal_amount > 0
        @balance -= withdrawal_amount
      else
        raise ArgumentError.new "Warning: You cannot withdraw a negative amount of money."
      end
    end

    def deposit(deposit_amount)
      if deposit_amount > 0
        @balance += deposit_amount
        @balance
      else
        raise ArgumentError.new "Warning: You cannot deposite a negative amount of money"
      end
    end
  end

  class Owner
    attr_reader :name, :address, :phone_number

    def initialize(name, address, phone_number)
      @name = name
      @address = address
      @phone_number = phone_number
    end
  end

end
