require File.expand_path('../account.rb', __FILE__)

module Bank
  class CheckingAccount < Bank::Account
    attr_accessor :number_of_checks
    #attr_reader :free_chashout
    def initialize(id, balance, openDate = '1999-03-27 11:30:09 -0800')
      super(id, balance, openDate = '1999-03-27 11:30:09 -0800')
      # @last_check_date #maybe =nil?
      @number_of_checks = 0
      @free_chashout = true
    end

    def withdraw(amount)
      super(amount)
      if @balance == 0
        puts "You can't have negative balance in your account"
        @balance += amount
      else
        return @balance -= 1
      end
    end

    def withdraw_using_check(check_amount)
      if @number_of_checks <= 3 && check_amount > 0
        @balance -= check_amount

        if @balance < -10
          puts "Overdraft is only allowed upto $10"
          @balance += check_amount
        else
          @number_of_checks +=1
        end
      else
        puts "Positive withdrawal amount is needed"
      end

      if @number_of_checks > 3
        #@free_chashout = false
        @balance -= 2
      end
      return @balance
    end

    def reset_checks
      @number_of_checks = 0
    end
  end
end

# checkingaccount = CheckingAccount.new(1212, 1000)
# # puts checkingaccount.withdraw_using_check(110)
# p checkingaccount.withdraw_using_check(200)
# p checkingaccount.withdraw_using_check(200)
# p checkingaccount.withdraw_using_check(200)
# p checkingaccount.withdraw_using_check(200)
# p checkingaccount.number_of_checks
# p checkingaccount.reset_checks
# p checkingaccount.number_of_checks
