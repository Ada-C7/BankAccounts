module Bank

  class Account
    attr_accessor :id, :balance

    def initialize(id, balance)
      @id = id

      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "You cannot initialize a new account with a negative balance."
      end

      def withdraw(withdrawal_amount)
        if withdrawal_amount > @balance
          puts "You are going negative."
        end
        @balance -= withdrawal_amount
      end


    end

  end

end
