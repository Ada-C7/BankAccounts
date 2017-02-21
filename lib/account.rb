module Bank
  class Account
    attr_reader :id
    attr_accessor :balance

    def initialize id, balance
      @id = id
      @balance = balance
      # if balance > 100
      #   @balance = balance
      # else raise ArgumentError.new "Enter a positive balance or 0."
      # end

    end
  end
end
