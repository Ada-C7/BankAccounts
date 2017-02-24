class CheckingAccount < Account
  def initialize
    super
  end
  
  def withdraw amount  #this is updating the withdraw method in the Account class
    # withdrawal fee of $1
    # Does not allow the account to go negative. Will output a warning message and return the original un-modified balance.
    #if > 3 checks, then charge a $2 check transaction fee
    #update number of checks cashed counter
  end

  def reset_checks #new method
    #resets number of checks cashed used to zero
  end

  def withdraw_using_check amount  #new method
  end


end
