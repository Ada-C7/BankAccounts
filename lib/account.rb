# Baseline
module Bank

  class Owner
    attr_reader :id, :name, :address

    def initialize(owner_id, name, address)
      @id = owner_id
      #@first_name = first_name
      #@last_name = last_nameß
      #@name = @first_name + " " + @last_name
      @name = name
      @address = address
    end

  end


  class Account

    attr_reader :balance, :id
    attr_accessor :owner_id

    def initialize (id, initial_balnce, owner_id = -1)

      if initial_balnce >= 0
        @balance = initial_balnce
      else
        raise ArgumentError.new "An account can't be created with negative balance"
      end
      @id = id
      @owner_id = owner_id
    end

    def withdraw(amount)
      if amount < 0
        raise ArgumentError.new "Invalid negative amount"
      elsif amount <= @balance
          @balance -= amount
      else
        puts "You don't have sufficient funds. Max withdrawel amount is #{@balance}."
      end
      return @balance
    end

    def deposit(amount)
      if amount < 0
        raise ArgumentError.new "Invalid negative amount"
      else
        @balance += amount
      end
      return @balance
    end
  end

  class BulkReader
    #attr_reader :number_of_accounts
    #attr_reader :number_of_owners

    def initialize
      @owners_array = []
      @accounts_array = []
      @number_of_accounts = 0
      @number_of_owners = 0
    end

    def bulk_import_accounts(filename)
      CSV.open(filename, 'r').each do |line|
        id = line[0].to_i
        balance = line[1].to_f
        #date = line[2]
        #puts "Acccount ID: #{id}, Balance: #{balance}, Open Date: #{date}"
        @accounts_array << Account.new(id, balance)
        #@number_of_accounts += 1
      end
    end

    def bulk_import_owners(filename)
      CSV.open(filename, 'r').each do |line|
        id = line[0].to_i

        first = line[1]
        last = line[2]
        name = first + " " + last

        address_street = line[3]
        address_city = line[4]
        address_state = line[5]
        address = address_street + ", " + address_city + ", " + address_state

        @owners_array << Owner.new(id, name, address)
        #@number_of_owners += 1
      end
    end

    def number_of_accounts
      return @accounts_array.length
    end

    def number_of_owners
      return @owners_array.length
    end

    def all_accounts
      return @accounts_array
    end

    def all_owners
      return @accounts_array
    end

    def find_account(account_id)
      @accounts_array.each do |account|
        if account.id = account_id
          return account
        end
      end
    end

    def find_owner(owner_id)
      @owner_array.each do |owner|
        if owner.id = owner_id
          return owner
        end
      end
    end

end
