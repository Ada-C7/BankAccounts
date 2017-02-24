require File.expand_path('../account.rb', __FILE__)

class CheckingAccount < Bank::Account
  #attr_accessor
  def initialize(id, balance, openDate = '1999-03-27 11:30:09 -0800')
    super(id, balance, openDate = '1999-03-27 11:30:09 -0800')

  end


  def withdraw_using_check(amount)

  end
end
