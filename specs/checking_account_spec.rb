require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/checking_account'
require_relative '../lib/account'



describe "CheckingAccount" do

  describe "#initialize" do

    it "Is a kind of Account" do
      account = Bank::CheckingAccount.new(12345, 10000)
      account.must_be_kind_of Bank::Account
    end
  end

  describe "#withdraw" do

    it "Applies a $1 fee each time" do
      account = Bank::CheckingAccount.new(12345, 1000)
      account.withdraw(500)
      account.balance.must_equal 400

      # withdrawal_amount(100)
      #
      # updated_balance = account.withdraw(withdrawal_amount)
      #
      # updated_balance.must_equal 9800

    end

    it "Doesn't modify the balance if the fee would put it negative" do

      account = Bank::CheckingAccount.new(12345, 1000)
      # starting_balance = account.balance
      account.withdraw(5000)
      account.balance.must_equal 1000

      # withdrawal_amount = 20000
      #
      # account.withdraw(withdrawal_amount)
      #
      # starting_balance.must_equal account.balance
    end
  end

  describe "#withdraw_using_check" do

    it "Reduces the balance" do
      start_balance = 50000
      withdrawal_amount = 250
      account = Bank::CheckingAccount.new(1337, start_balance)

      account.withdraw_using_check(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount

      account.balance.must_equal expected_balance

    end

    it "Returns the modified balance" do

      account = Bank::CheckingAccount.new(12345, 2000 )
      withdrawal_amount = 500
      expected_balance = 1500

      updated_balance = account.withdraw_using_check(withdrawal_amount)


      expected_balance.must_equal updated_balance
    end

    it "Allows the balance to go down to -$10" do



    end

    it "Outputs a warning if the account would go below -$10" do

      start_balance = 10000
      withdrawal_amount = 20000
      account = Bank::CheckingAccount.new(1337, start_balance)

      proc {
        account.withdraw_using_check(withdrawal_amount)
      }.must_output(/.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do


      account = Bank::CheckingAccount.new(12345, 2000 )

      account_balance = account.balance

      account_balance.must_be :>, 1000

    end

    it "Requires a positive withdrawal amount" do
      # account = Bank::CheckingAccount.new(12345, 2000 )

      amount = -1000
      amount.wont_be :> , 0

    end

    it "Allows 3 free uses" do

      # TODO: Your test code here!
    end

    it "Applies a $2 fee after the third use" do
      account = Bank::CheckingAccount.new(12345, 10000 )
      account.withdraw_using_check(1000)
      account.withdraw_using_check(1000)
      account.withdraw_using_check(1000)
      x = account.withdraw_using_check(1000)

      x.must_equal 5800


    end

    describe "#reset_checks" do

      it "Can be called without error" do

        account = Bank::CheckingAccount.new(12345, 2000 )
        @checks_used = 0
        account.must_respond_to :checks_used
      end


    end

    it "Makes the next three checks free if less than 3 checks had been used" do

      account = Bank::CheckingAccount.new(12345, 5000)
      @checks_used = 0
      account.withdraw_using_check(1000)
      account.withdraw_using_check(1000)
      account.withdraw_using_check(1000)
      account.balance.must_equal 2000
    end


    it "Makes the next three checks free if more than 3 checks had been used" do
      account = Bank::CheckingAccount.new(12345, 10000)
      @checks_used = 0
      account.withdraw_using_check(1000)
      account.withdraw_using_check(1000)
      account.withdraw_using_check(1000)
      account.reset_checks
      account.withdraw_using_check(1000)
      account.withdraw_using_check(1000)
      account.withdraw_using_check(1000)
      account.balance.must_equal 4000
    end
  end
end
