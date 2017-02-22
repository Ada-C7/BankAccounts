require_relative 'owner'

module Bank
  class Account
    attr_reader :id, :balance, :owner

    def initialize id, balance
      @id = id
      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "Initial balance must be more than zero."
      end
      @owner

    end

    def withdraw(new_withdrawal)
      if new_withdrawal <=0
        raise ArgumentError.new "You must withdraw a positive amount"
      elsif new_withdrawal > @balance
        puts "You do not have enough money to make that withdrawal"
        @balance
      else
        @balance -= new_withdrawal
      end
    end

    def deposit(new_deposit)
      if new_deposit <= 0
        raise ArgumentError.new "Your deposit amount must have a positive value"

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
