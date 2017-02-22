module Bank

  class Account
    attr_accessor :balance
    attr_reader :id

    def initialize(id, balance)
      @id = id

      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "The value must be between greater than or equal to 0"
      end
    end

    # def owner
    #
    # end

    def withdraw(withdrawal_amount)

      if withdrawal_amount > @balance
        puts "Warning! You are about to withdraw more money than you have in your account."
        #withdrawal_amount = 0
        @balance
      elsif withdrawal_amount > 0
        @balance -= withdrawal_amount
      else
        raise ArgumentError.new "Warning: You cannot withdraw a negative amount of money."
      end
    end

    def deposit(deposit_amount)
      if deposit_amount > 0
        @balance += deposit_amount
        return @balance
      else
        raise ArgumentError.new "Warning: You cannot deposite a negative amount of money"
      end
    end
  end

  class Owner
    attr_reader :name, :address, :phone_number

    def initialize(name, address, phone_number)
      @name = name
      @address = address
      @phone_number = phone_number
    end
  end

end

# user_info = [
#   {
#     :name => "Elmo"
#     :address => ""
#     :phone_number =>
#   },


]
