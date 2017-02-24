require_relative 'account'

module Bank
  class CheckingAccount < Bank::Account

    def initialize(id, balance, date)
      super(id, balance, date)
    end

    def withdraw(withdrawal_amount)
      if (@balance - withdrawal_amount - 100) < 0
        puts "You can't withdraw that much"
        return @balance
      end

      super(withdrawal_amount)

      return @balance -= 100 #interpreting 100 as $1.00
    end

  end
end
