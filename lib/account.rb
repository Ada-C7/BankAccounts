module Bank
  class Account
    attr_reader :id
    attr_accessor :balance

    def initialize id, start_balance
      @id = id

      if start_balance >= 0
        @balance = start_balance
      else raise ArgumentError.new
      end

    def withdraw(withdrawal_amount)
      @balance = @balance - withdrawal_amount
    end

    end
  end
end
