require 'time'
require_relative 'account'

module Bank
  class CheckingAccount < Account
    def initialize(id, balance, opendate)
      super(id, balance, opendate)
      
    end

  end
end
