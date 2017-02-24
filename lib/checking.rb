
require 'csv'
require 'pry'
require_relative 'account.rb'


module Bank
  class CheckingAccount < Account

    #attr_accessor :balance

    def initialize(account)
      super
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

  end
end
