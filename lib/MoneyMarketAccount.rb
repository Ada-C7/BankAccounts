require_relative 'account_wave_2'

module Bank

  class MoneyMarketAccount < Account
    attr_reader :transactions, :balance, :id, :too_low, :max_trans_reached

    def initialize(id, starting_balance)
      raise ArgumentError.new "starting must be >= 10000" if starting_balance < 10_000
      @id = id
      @balance = starting_balance
      @too_low = false
      @transactions = 0
      @max_trans_reached = false

      @withdraw_fee = 100
    end

    def withdraw(amount)

      if @too_low || @max_trans_reached
        puts "You can't withdraw right now!"
        return
      else
        if @balance - amount < 10000
          @too_low = true
          @balance -= @withdraw_fee + amount
          puts "You need to get your balance back up to 10k!"
          @transactions += 1
          return
        else
          @balance -= amount
          @transactions += 1
        end
      end
      check_num_of_transactions
      # super
    end

    def deposit(amount)
      # each deposit increases number of transactions
      # unless the deposit brings the acct back up to 10k
      #
      # IF not too low AND max trans
      if !@too_low && @max_trans_reached
        #   you cant do anything
        puts "Max transactions reached."
        return @balance
      end
      # ELSIF too low AND deposit brings back to 10k
      if @too_low && @balance + amount >= 10000
      #   update balance
        @balance += amount
      #   reset too low to false
        @too_low = false
        # return @balance
      # ELSIF not too low AND not max trans
      elsif !@too_low && !@max_trans_reached
      #   regular deposit happens
      #     balance is updated
        @balance += amount
      #     transactions increased
        @transactions += 1
        return @balance
      end
      check_num_of_transactions
    end

    def check_num_of_transactions
      if @transactions >= 6
        @max_trans_reached = true
      end
    end


    def add_interest(rate)
      if rate < 0
        puts "rate must be positive"
        return
      else
        interest_amount = (@balance * (rate / 100)).to_f
        @balance += interest_amount
        return interest_amount
      end
    end

    def reset_transactions
      @transactions = 0
    end

  end

end


      # if @too_low
      #   if @balance + amount < 10000
      #     puts "Your deposit must get you back up to 10k!"
      #   elsif @balance + amount >= 10000
      #     @balance += amount
      #     @too_low = false
      #   end
      # elsif @transactions >= 6
      #   @max_trans_reached = true
      #   puts "Sorry, you've reached your max transactions for the month."
      # else
      #   @balance += amount
      #   @transactions += 1
      #   if @transactions >= 6
      #     @max_trans_reached = true
      #   end
      # end
