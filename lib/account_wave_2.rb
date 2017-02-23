require 'csv'
# require_relative '../support/accounts.csv'

module Bank
  class Account

    def self.find(search_for_id)
      all_accounts = Bank::Account.all
      answer = nil
      all_accounts.each do |account|
        answer = account if account.id.to_i == search_for_id.to_i

      end
      raise ArgumentError.new "That account id doesn't exist!" if answer == nil
      return answer
    end

    def self.all
      my_file = CSV.open("support/accounts.csv")
      all_accounts = []
      my_file.each do |line|
        account = Account.new(line[0], line[1].to_f, line[2])

        # account = Account.new(line[0], (sprintf("%.01f",line[1])).to_f / 100, line[2])
        all_accounts << account
      end
      return all_accounts
    end

    attr_reader :id, :balance, :owner, :open_date
    def initialize(id, balance, open_date=nil, owner=nil)
      if balance < 0
        raise ArgumentError.new "Can't be negative starting balance"
      end
      @id = id
      @balance = balance
      @open_date = open_date
      @owner = owner
    end

    def withdraw(withdrawal_amount)
      if withdrawal_amount > @balance
        puts "You cannot withdraw more than you have in your account!"
        @balance = @balance
      elsif withdrawal_amount < 0
        raise ArgumentError.new "You cannot withdraw a negative amount."
      else
        @balance -= withdrawal_amount
      end
    end

    def deposit(deposit_amount)
      if deposit_amount < 0
        raise ArgumentError.new "Cannot deposit a negative amount."
      end
      @balance += deposit_amount
    end


  end # end of Account class

  class Owner
    attr_reader :name, :address
    def initialize(name=nil, address=nil)
      @name = name
      @address = address
    end
  end
end

# Bank::Account.all
