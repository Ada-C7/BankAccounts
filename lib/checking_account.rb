require_relative 'account'

module Bank
  class CheckingAccount< Account
    attr_accessor :id, :balance

    def initialize(id, balance)
      super(id, balance)
      @check_count = 0
      @fee = 2
      raise ArgumentError.new("balance must be >= -1-") if balance < 10
    end

    def withdraw(amount)
      if amount < (@balance - 11)
        puts "Outputs a warning if the balance would go below $10"
        return @balance -= (amount + 1)
      else
        return @balance
      end
    end

    def withdraw_using_check(amount)
      raise ArgumentError.new("Invalid amount, try again.") if amount < 0

      if (@check_count < 3) && (@balance - amount) >= -10
        @check_count += 1
        @balance -= amount
      elsif (@check_count >= 3) && (@balance - amount) >= -12
        @balance -= (amount + 2)
      else
        puts "Sorry, can't go below -$10"
      end
      return @balance
    end

    def reset_checks
      @check_count = 0
    end
  end

end
