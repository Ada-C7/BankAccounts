module Bank
  class CheckingAccount < Account
    def initialize(id, balance, open_date = '2012 - 12-21 12:21:12 -0800')
      super(id, balance, open_date)
    end

    def withdraw(amount)
      new_balance = @balance - amount
      if new_balance < 1
        puts "You don't have enough money in your account"
      else
        super(amount)
        return @balance -= 1
      end
    end

    def withdraw_using_check(amount)
      new_balance = @balance - amount
      check_count = 0
      if new_balance < -10
        # puts "You don't have enough money in your account"
      else
        raise ArgumentError, "Withdrawals should be a positive number" unless amount >=0
        check_count += 1
        return @balance = @balance - amount
      end

    end

  end
end

# 30347
