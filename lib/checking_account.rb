require_relative 'account'

module Bank
  class CheckingAccount < Bank::Account
    attr_reader :id, :amount
    attr_accessor :num_withdrawal
    def initialize(id, balance)
      # super(id, balance)
      @id = id
      @balance = balance
      raise ArgumentError.new("balance must be >= 0") if balance < 10
      @num_withdrawal = 0
    end

    def withdraw(amount)
      if @balance - (amount + 1) < 10
        puts "balance must be greater than 0"
        return @balance
      else
        return @balance = @balance - (amount + 1)
      end
    end

    def withdraw_using_check(amount)
      if amount < 0
        puts "Withdrawl amount must be greater than 0"
      else
        if @balance - amount < -10
          puts "balance must be greater than -10"
          return @balance
        else
          if @num_withdrawal >= 3
            return @balance = @balance - (amount + 2)
          else
            @num_withdrawal += 1
            # puts @num_withdrawal
            return @balance = @balance - amount
          end
        end
      end
    end

    def reset_checks
      @num_withdrawal = 0
      return "reset"
    end

  end
end

# a = Bank::CheckingAccount.new(1234, 5000)
# a.withdraw_using_check(10)
# puts a.balance
# a.withdraw_using_check(10)
# puts a.balance
# a.withdraw_using_check(10)
# puts a.balance
# a.withdraw_using_check(10)
# puts a.balance

# puts Bank::CheckingAccount.new(1234, 5000)
