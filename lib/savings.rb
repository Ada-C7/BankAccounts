require 'csv'
require 'pry'
require_relative 'account.rb'


module Bank
  class SavingsAccount < Account

    attr_accessor

    def initialize(account)

      @id = account[:id].to_i
      @balance = account[:balance].to_i
      @opendatetime = account[:opendatetime]

      if @balance >= 10
        @balance = @balance
      else
        raise ArgumentError.new "Savings Accounts must have an Initial Balance of $10"
      end


    end

  end
end
