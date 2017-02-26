


#   attr_accessor :id, :balance, :created
#
#   def initialize(id, balance, created = nil)
#
#     raise ArgumentError.new "Balance must be positive or 0" unless balance >= 0
#     @id = id
#     @balance = balance
#     @created = created
#   end
#
#   def self.all
#     accounts = []
#
#     CSV.read("accounts.csv").each do |line|
#       id = line[0].to_i
#       balance = line[1].to_i
#       created = line[2]
#
# account = Bank::Account.new(id, balance, created)
#
#       accounts << account
#     end
#
#     accounts
#   end

module Bank
  class CheckingAccount < Bank::Account



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
      @checks_used += 1
      if @checks_used <= 3
        fee = 0
      else
        fee = 200
      end
      puts @checks_used
      puts fee
      if @balance - amount - fee < - 1000
        puts " Warning, only allowed $10 overdraft"
      else
        @balance -= amount + fee

      end # this is for if

      balance

      raise ArgumentError.new "Balance must be more than 10" unless @balance > 1000




      def reset_checks
        @checks_used = 0
      end # reset checks end





    end # end for withdraw







  end # This is for the class
end
# lisy = CheckingAccount.new(123, 1000)
# # puts lisy.withdraw(2000)
# puts lisy.withdraw_using_check(100)
# puts lisy.withdraw_using_check(100)
# puts lisy.withdraw_using_check(100)
# puts lisy.withdraw_using_check(100)
# puts lisy.withdraw_using_check(100)
