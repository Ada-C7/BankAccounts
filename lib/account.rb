require 'csv'

module Bank

  class Account
    attr_accessor :balance
    attr_reader :id, :owner

    def initialize(id, start_balance, opendate = nil)

      @id = id
      @opendate = opendate
      @balance = set_balance(start_balance)

    end

    def set_balance(start_balance)

      if start_balance < 0
        argument("You cannot initialize a new account with a negative balance.")
      else
        start_balance
      end

    end

    def self.all

      accounts = []

      CSV.open("support/accounts.csv").each do |account|
        accounts << Bank::Account.new(account[0].to_i, account[1].to_i, account[2])
      end
      return accounts

    end

    def self.find(id)

      @account = nil

      CSV.open("support/accounts.csv").each do |line|
        if line[0].to_i == id
          @account = Bank::Account.new(line[0].to_i, line[1].to_i, line[2])
        end
      end

      if @account == nil
        raise ArgumentError.new "This account does not exist!"
      else
        return @account
      end

    end

    def add_owner(owner)

      if owner.class == Owner
        @owner = owner
      else
        argument("You must add a class type of Owner.")
      end

    end

    def withdraw(withdrawal_amount)

      withdraw_positive(withdrawal_amount)

      if balance - withdrawal_amount < 0
        puts "You are going negative."
        return balance
      else
        @balance -= withdrawal_amount
      end

    end

    #Should this be private??
    #b/c only used in check_withdrawals?
    def withdraw_positive(withdrawal_amount)

      #makes sure the withdrawal amount is pos.
      argument("Withdrawal must be >= 0") if withdrawal_amount < 0

    end

    def deposit(deposit_amount)

      if deposit_amount > 0
        @balance += deposit_amount
      else
        argument("Your deposit must be greater than zero.")
      end

    end

    def argument(output)

      raise ArgumentError.new "#{ output }"

    end

  end

  class Owner

    attr_reader :last_name, :first_name, :street_address, :city, :state

    def initialize(

      id = nil, last_name = nil,
      first_name = nil, street_address = nil,
      city = nil, state = nil)
      @id = id
      @last_name = last_name
      @first_name = first_name
      @street_address = street_address
      @city = city
      @state = state

    end

    def self.all

      owners = []
      CSV.open("support/owners.csv").each do |owner|
        owners << Bank::Owner.new(
        owner[0].to_i, owner[1],
        owner[2], owner[3],
        owner[4], owner[5])
      end

      return owners

    end

    def self.find(id)

      @owner = nil
      CSV.open("support/owners.csv").each do |owner|
        if owner[0].to_i == id
          @owner = Bank::Owner.new(
          owner[0].to_i, owner[1],
          owner[2], owner[3],
          owner[4], owner[5])
        end

      end

      if @owner == nil
        raise ArgumentError.new "This owner does not exist!"
      else
        return @owner
      end
      
    end

  end

end
