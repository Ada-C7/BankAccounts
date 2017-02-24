require 'csv'
require_relative '../lib/account'

module Bank

  class SavingsAccount < Account
    attr_reader :id, :balance
    def initialize(id, balance)
      @id = id
      @balance = balance
    end
  end


end 
