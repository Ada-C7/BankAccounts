require_relative 'account'

module Bank

  class MoneyMarketAccount < Account
    attr_accessor :transactions

    def initialize(id, balance)
        super(id, balance)
        @transactions = 6
      end

    end

  end
