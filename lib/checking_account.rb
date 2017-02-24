require 'csv'
require_relative '../lib/account'

module Bank

  class CheckingAccount < Account
    attr_reader :id, :balance
    def initialize(id, balance)
      @id = id
      @balance = balance
      @check_num = 0
      @withdrawal_fee = 0

      def withdraw(withdrawal_amount)
        check_balance = @balance - (withdrawal_amount + 1)
        if check_balance < 0
          puts "Warning, this will be below 0 , " + (@balance.to_s)
        else
          super + (-1)
        end
      end

      def withdraw_with_check(withdrawal_amount)
        # counter to see how many checks drawn
        # keep track of what check fee is, at one point at 4 goes up to 2
        if withdrawal_amount < 0
          raise ArgumentError.new "You cannot withdraw a negative amount"
        elsif @balance - (withdrawal_amount + 1) < -10
          puts "Warning, the balance cannot be negative "
          return @balance
          # elsif withdrawal_amount < 0
          #     raise ArgumentError.new "You cannot withdraw a negative amount"
        end

        if @check_num >= 3
          @withdrawal_fee = 2
        end

        @balance -= (withdrawal_amount + 1)


      end

      def reset_checks
        # if reset_checks >= 3
        #   reset_checks = 0
        # end
      end
    end


    # checking_account = CheckingAccount.new(11, 200)
    #
    # puts checking_account.withdraw(10)
  end
end
