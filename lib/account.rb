# Janice Lichtman's Bank Accounts - Wave 1

require_relative 'owner'

module Bank
  class Account
    attr_reader :id, :balance
    attr_accessor :owner

    def initialize(id, balance)
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      @id = id
      @balance = balance

    end

    def withdraw(withdrawal_amount)
      raise ArgumentError.new("Withdrawal amount must be >= 0") if withdrawal_amount < 0
      if withdrawal_amount > @balance
        puts "You don't have enough in your account to withdraw that amount!"
      else @balance -= withdrawal_amount
      end
      return @balance
    end

    def deposit(deposit_amount)
      raise ArgumentError.new("Deposit amount must be >= 0") if deposit_amount < 0
      @balance += deposit_amount
    end

  end
end

# acct = Bank::Account.new('4567',100)
# acct.owner = Bank::Owner.new(name:"Janice Lichtman", address:"512A N 46th St, Seattle, WA", birthday:"May 16, 1974", pets_name: "Marshmallo")
#
# puts acct.owner
# puts acct.owner.birthday
