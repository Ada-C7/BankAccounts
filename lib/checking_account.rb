require_relative 'account'

module Bank
  class CheckingAccount < Account
    def initialize (id, balance)
      super(id, balance)
      @checks = 0
    end

    def withdraw(withdraw_amount)
      fee = 1
      if @balance < withdraw_amount
        puts "You dont have enough funds!"
        return @balance
      end
      @balance -= (withdraw_amount + fee)
    end

    def withdraw_using_check(amount)
      raise ArgumentError.new("unvalid amount!") if amount < 0

      if (@balance - amount) < -10
        print "warning! Your balance would go under -$10"
        return @balance
      end
      raise ArgumentError.new("No enough funds") if (@balance - amount) < -10

      @checks += 1
      fee = 2.0
      return @balance -= (amount + fee) if @checks > 3
      @balance -= amount
    end

    def reset_checks
      @checks = 0
    end
  end
end
