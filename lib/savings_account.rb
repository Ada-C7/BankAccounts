require 'csv'
require_relative '../lib/account'

module Bank

  class SavingsAccount < Account
    attr_reader :id, :balance

    def initialize(id, balance)

      raise ArgumentError.new "Balance must be at least $10" unless balance >= 10
      @id = id
      @balance = balance
    end

    def withdraw(withdrawal_amount)
      super + (-2)
    end




  end


end
