require_relative 'owner'

module Bank
  class Account
    attr_reader :id, :balance, :owner

    def initialize id, balance, opendate
      @id = id
      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "Initial balance must be more than zero."
      end
      @opendate = opendate
      @owner

    end

    def self.all  #reads in csv file and returns collection of Account instances

    end

    def self.find(id) #returns an instance of Account that matches the passed id parameter
    end

    def withdraw(new_withdrawal)
      # raise ArgumentError.new("You must withdraw a positive amount") if new_withdrawal < 0 #alternate if statement for one-line conditional
      if new_withdrawal <=0
        raise ArgumentError.new "withdrawal must be greater than 0"
      elsif new_withdrawal > @balance
        puts "Insufficient funds"  #puts statement returns nil
        @balance #this is what is returned by this elsif
      else
        @balance -= new_withdrawal
      end
    end

    def deposit(new_deposit)
      if new_deposit <= 0
        raise ArgumentError.new "deposit amount must be greater than 0"

      else
        @balance += new_deposit
      end

    end

    def get_owner_info(owner_hash)
      @owner = Bank::Owner.new(owner_hash)

    end



  end
end

owner_hash = {
  :in_first_name => "Grace",
  :in_last_name => "Hopper",
  :in_address => "456 Anytown, USA",
  :in_phone => "206-440-0725"
}

new_account = Bank::Account.new(1375, 200)
new_account.get_owner_info(owner_hash)
