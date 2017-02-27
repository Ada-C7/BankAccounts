require_relative 'account'

module Bank
  class CheckingAccount < Account
    attr_reader :balance
    def initialize(id, balance, open_date = "1999-03-27 11:30:09 -0800")
      super(id, balance, open_date)
      @check_count = 1
    end

    def withdraw(amount)
      if @balance < amount + 1
        raise ArgumentError.new("Insufficient funds")
      end
        @balance = super(amount + 1)
    end

    def withdraw_using_check(amount)

      if amount < 0
        raise ArgumentError.new("withdrawal can't be negative number.")
      end

      if @balance - amount < -10
        raise ArgumentError.new ("Negative balance cannot exceed -$10")
      end
      if @check_count > 3
        @balance -= (amount + 2)
        @check_count += 1
      elsif
        @balance -= amount
        @check_count += 1
        return @balance
      end
    end

    def reset_checks
      return @check_count = 1
    end

  end
end
