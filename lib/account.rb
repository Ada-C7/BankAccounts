module Bank


class Account
  attr_accessor :id, :balance

  def initialize(id, balance)
    @id = id
    unless balance >= 0
      raise ArgumentError.new "Balance must be greater or equal to 0"
    end
    @balance = balance
  end

  # def balance
  # end
end

end
