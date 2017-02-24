require_relative 'account'

module Bank
  class Test < Bank::Account
    def initialize(id, balance)
      super(id, balance)
    end

    def deposit(amount)
      super(amount)
      @balance = @balance + 10
    end
  end
end
a = Bank::Test.new(1234, 5000)
puts a.deposit(50)
