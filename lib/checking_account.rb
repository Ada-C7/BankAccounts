module Bank
  class CheckingAccount < Account
    attr_reader :check_count
    def initialize(id, balance)
      @id = id
      @balance = balance
      @check_count = 0
      # super()
    end

    def withdraw(amount)
      amount += 1
      raise ArgumentError.new("amount must be >= 0") if amount < 0
      if (@balance - amount) < 0
        puts "whoops! you don't have that much money in your account! your balance is #{@balance}."
        return @balance
      else
        return @balance -= amount
      end
    end

    def withdraw_using_check(amount)
      raise ArgumentError.new("amount must be >= 0") if amount < 0
    if @check_count > 2
      amount += 2
    end
    if @balance - amount < -10
      puts "whoops! you don't have that much money in your account! your balance is #{@balance}."
      return @balance
    else
      @check_count += 1
      return @balance -= amount
    end
    end

    def reset_checks
      @check_count = 0
    end
  end
end
