require_relative 'account.rb'
module Bank
  class CheckingAccount < Account
    attr_reader :count

    def initialize(id = "", balance = 10, date_opened = "" )
      @count = 0
      super(id, balance, date_opened)
      if balance < 10
        raise ArgumentError.new("balance must be >= 10")
        puts "balance must be >= 10"
      end
    end

    def withdraw(amount,limit= 10)
      total_withdrawl = amount + 1
      super(total_withdrawl, -10)
      return @balance
    end


    def withdraw_using_check(amount,limit= -10)
      if count <= 3
        withdraw((amount - 1))
        @count += 1
      elsif count >= 4
        withdraw((amount + 1))
        @count += 1
      end
      return balance
    end

  end
end
opening_balance = 100
withdrawal_amount = 10
account = Bank::CheckingAccount.new(12345, opening_balance)
puts account.withdraw_using_check(withdrawal_amount)
