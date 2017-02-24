require 'csv'
require 'pry'
require_relative 'account.rb'


module Bank
  class SavingsAccount < Account

    attr_accessor

    def initialize(account_hash)
      super
    end

  end
end
