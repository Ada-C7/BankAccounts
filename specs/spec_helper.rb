require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'CSV'

require_relative '../lib/account'
require_relative '../lib/checking_account'
require_relative '../lib/money_market_account'
require_relative '../lib/savings_account'
