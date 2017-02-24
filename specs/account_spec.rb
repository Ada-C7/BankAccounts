require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/account'
require 'time'

# TESTS FOR WAVE2
describe "Wave 2" do
  describe "Account.all" do
    it "Account.all returns an array" do
      all_accounts = Bank::Account.all
      all_accounts.must_be_kind_of Array
    end

    it "Everything in the array is an Account" do
      all_accounts = Bank::Account.all
      all_accounts.each do |instance|
        instance.must_be_kind_of Bank::Account
      end
    end

    it "The number of accounts is correct" do
      expected_rows = 12
      all_accounts = Bank::Account.all
      all_accounts.length.must_equal expected_rows
    end

    it "ID + balance of first/last accounts match .csv" do
      all_accounts = Bank::Account.all
      expected_first_id = 1212
      expected_last_id = 15156
      all_accounts.first.id.must_equal expected_first_id
      all_accounts.last.id.must_equal expected_last_id
      expected_first_balance = 1235667
      expected_last_balance = 4356772
      all_accounts.first.balance.must_equal expected_first_balance
      all_accounts.last.balance.must_equal expected_last_balance
    end
  end

  describe "Account.find" do
    it "Returns an account that exists" do
      get_id = 1212
      found_account = Bank::Account.find(get_id)
      expected_id = get_id
      expected_balance = 1235667
      expected_date = Time.parse("1999-03-27 11:30:09 -0800")
      found_account.id.must_equal expected_id
      found_account.balance.must_equal expected_balance
      found_account.opendate.must_equal expected_date
    end

    it "Can find the first account from the CSV" do
      get_id = 15151
      found_account = Bank::Account.find(get_id)
      expected_id = get_id
      expected_balance = 9844567
      expected_date = Time.parse("1993-01-17 13:30:56 -0800")
      found_account.id.must_equal expected_id
      found_account.balance.must_equal expected_balance
      found_account.opendate.must_equal expected_date
    end

    it "Can find the last account from the CSV" do
      get_id = 15156
      found_account = Bank::Account.find(get_id)
      expected_id = get_id
      expected_balance = 4356772
      expected_date = Time.parse("1994-11-17 14:04:56 -0800")
      found_account.id.must_equal expected_id
      found_account.balance.must_equal expected_balance
      found_account.opendate.must_equal expected_date
    end

    it "Raises an error for an account that doesn't exist" do
      proc {
        Bank::Account.find(666) # non-existent account number
      }.must_raise ArgumentError
    end
  end
end
