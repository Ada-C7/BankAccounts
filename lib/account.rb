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

      def withdraw

      end

    end

  end

end
