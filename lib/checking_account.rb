require 'csv'
require_relative '../lib/account'

module Bank

  class CheckingAccount < Account
    attr_reader :id, :balance
    def initialize(id, balance)
      @id = id
      @balance = balance
      @check_num = 3

      def withdraw(withdrawal_amount)
        check_balance = @balance - (withdrawal_amount + 1)
        if check_balance < 0
          puts "Warning, this will be below 0 , " + (@balance.to_s)
        else
          super + (-1)
        end
      end

      def withdraw_with_check(withdrawal_amount)
        if withdrawal_amount < 0
          raise ArgumentError.new "You cannot withdraw a negative amount"
        elsif (@balance - withdrawal_amount) <= -11
          puts "Warning, the balance cannot be negative "
          return @balance
        else
          withdrawal_fee = 0
          @balance -= withdrawal_amount + withdrawal_fee
          @check_num -= 1
          if @check_num < 0
            withdrawal_fee = 2
            @balance -= withdrawal_fee
          end
        end
      end
    end


    def reset_checks
      if @check_num <= 0
        @check_num = 3
      end
    end

  end
end
