require_relative 'account'


module Bank
  class CheckingAccount < Account

    def initialize(id, balance, timedate = nil)
      raise ArgumentError.new("balance must be greater than zero") if balance < 0
      @id = id
      @balance = balance
      @timedate = timedate
    end


  end#class CheckingAccount
end#module Bank
