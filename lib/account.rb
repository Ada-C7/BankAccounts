#all ruby code should be in the lib folder. it should be lib/class_name.rb
#the specs will be in that directory specs/class_name_spec.rb
#this is where I do the first wave. only in one class

module Bank
  class Account
    attr_reader :id, :balance

    def initialize(id, balance)
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
    end

    def withdraw(amount)
      raise ArgumentError.new("Withdraw amount must be a positive integer") if amount < 0
      if @balance < amount
        puts "Warning: desired withdrawl amount exceeds account balance."
        return @balance
      else
        @balance -= amount
        return @balance
      end
    end

    def deposit(amount)
      raise ArgumentError.new("Deposit amount must be a positive integer") if amount < 0
      @balance += amount
      return @balance
    end
  end
end
