
require 'csv'
require 'pry'
require_relative 'account.rb'


module Bank
  class CheckingAccount < Account

    attr_accessor :balance, :checks

    def initialize(account)
      super
      @checks = 3
    end

    def withdraw(amount)

      if @balance - (amount + 1) < 1
        print "Insufficient Funds"
        @balnace = @balance
      else
        @balance -= (amount + 1)
        return @balance
      end

    end

    def check_withdraw(amount)

      check_fee = 0

      if @checks < 1
        check_fee = 2
      end


      if @balance - (amount + check_fee) < 10
        print "Insufficient Funds"
        @balnace = @balance
      else
        @balance = @balance - (amount + check_fee)
        return @balance
      end

    end

  end
end
