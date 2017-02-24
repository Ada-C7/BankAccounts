require_relative 'account'

module Bank
  class SavingsAccount < Bank::Account

    def initialize(id, balance, date)
      super(id, balance, date)

      #interpreting 1000 as 10.00 because of how the csv file defined balance
      raise ArgumentError.new "Balance must be at least 1000" if @balance < 1000
    end

    def withdraw(withdrawal_amount)
      if (@balance - withdrawal_amount - 200) < 1000
        puts "You can't withdraw that much"
        return @balance
      end
      super(withdrawal_amount)
      @balance -= 200 #interpreting 200 as $2.00
    end
  end
end
