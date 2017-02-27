require_relative 'account'

module Bank
  class CheckingAccount< Account
    attr_accessor :id, :balance

    def initialize(id, balance)
      super(id, balance)
    end

    def withdraw(amount)
      if amount < (@balance - 11)
        puts "Outputs a warning if the balance would go below $10"
        return @balance -= (amount + 1)
      else
        return @balance
      end
    end

  end
end
