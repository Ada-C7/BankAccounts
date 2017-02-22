require_relative 'owner'
module Bank
  class Account
    attr_reader :id, :balance, :owner
    def initialize(id, balance)
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      @id = id
      @balance = balance
    end

    def add_owner(name, address, phone)
      @owner = Bank::Owner.new(name, address, phone)
    end

    def withdraw(amount)
      # TODO: implement withdraw
      if amount < 0
         raise ArgumentError.new("amount to withdraw cannot be less than 0")
       end
      if @balance - amount < 0
        puts "Warning: This ammount cannot be withdrawed; your balance cannot be negative"
      else
        @balance -= amount
      end
      puts "Your balance now is #{@balance}"
      return @balance
    end

    def deposit(amount)
      # TODO: implement deposit
      if amount < 0
         raise ArgumentError.new("amount to withdraw cannot be less than 0")
       end
      @balance += amount
      return @balance
    end
  end # end of class Account
end # end of module Bank


account = Bank::Account.new(12, 300)
puts account.withdraw(200)
puts account.deposit(500)
puts account.balance
account.add_owner("Natalia", "123 Main Street", "4252959102")
puts account.owner
puts account.owner.name
