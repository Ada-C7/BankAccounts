require 'time'
require_relative 'account'

module Bank
  class CheckingAccount < Account
    def initialize(id, balance, opendate)
      super
      @withdraw_fee = 1.0
      @minimum_balance = 0
    end

    def withdraw(amount)
      super
    end

  end
end
