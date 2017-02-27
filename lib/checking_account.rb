require_relative 'account'

module Bank
  class CheckingAccount < Account

    attr_accessor :checks_used

    def initialize( id, balance, checks_used = 0)

      super(id, balance)
      @checks_used = checks_used

    end #this is for initialize


    def withdraw(amount)
      raise ArgumentError.new if amount < 0
      fee = 100
      if @balance - amount - fee < -1000
        puts "Sorry, minimum $10 balance."
      else
        @balance = @balance - amount - fee
      end
      @balance
    end #withdraw end





    def withdraw_using_check(amount)
        fee = 0
      @checks_used += 1
      if @checks_used <= 3
        fee = 0.0
      else
        fee = 200.0
      end
    #  puts "#{@checks_used}  :    #{fee}"

      if @balance - amount - fee < - 1000
        puts " Warning, only allowed $10 overdraft"
      else
        @balance -= amount + fee

      end # this is for if
      # print @balance
      return @balance

      # raise ArgumentError.new "Balance must be more than 10" unless @balance > 1000


    end # end for withdraw


    def reset_checks
      @checks_used = 0
    end # reset checks end





  end # This is for the class
end
  #
  # lisy = Bank::CheckingAccount.new(123, 10000)
  #
  # puts lisy.withdraw_using_check(1000)
  # puts lisy.withdraw_using_check(1000)
  # puts lisy.withdraw_using_check(1000)
  # puts lisy.withdraw_using_check(1000)
