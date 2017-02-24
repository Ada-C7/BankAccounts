
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

      if @balance - (amount + 1) < 0
        raise ArgumentError.new "Insufficient Funds"
      end

      @balance -= (amount + 1)
      return @balance

    end

  end
end
