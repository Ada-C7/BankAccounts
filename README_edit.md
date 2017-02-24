in cents (i.e., 150 would be $1.50)

## Wave 3
### Learning Goals
- Use inheritance to share some behavior across classes
- Enhance functionality built in Wave 1

### Requirements

For wave 3, you will create two new classes: `SavingsAccount` and `CheckingAccount`. Both should inherit behavior from the `Account` class. Each class should get its own file under the `lib/` directory, and each already has a spec file with stub tests.

#### SavingsAccount
Create a `SavingsAccount` class which should inherit behavior from the `Account` class. It should include the following updated functionality:
- The initial balance cannot be less than $10. If it is, this will `raise` an `ArgumentError`
- Updated withdrawal functionality:
  - Each withdrawal 'transaction' incurs a fee of $2 that is taken out of the balance.
  - Does not allow the account to go below the $10 minimum balance - Will output a warning message and return the original un-modified balance

It should include the following new method:
- `#add_interest(rate)`: Calculate the interest on the balance and add the interest to the balance. Return the **interest** that was calculated and added to the balance (not the updated balance).
  - Input rate is assumed to be a percentage (i.e. 0.25).
  - The formula for calculating interest is `balance * rate/100`
    - Example: If the interest rate is 0.25 and the balance is $10,000, then the interest that is returned is $25 and the new balance becomes $10,025.

#### CheckingAccount
Create a `CheckingAccount` class which should inherit behavior from the `Account` class. It should include the following updated functionality:
- Updated withdrawal functionality:
  - Each withdrawal 'transaction' incurs a fee of $1 that is taken out of the balance. Returns the updated account balance.
    - Does not allow the account to go negative. Will output a warning message and return the original un-modified balance.
- `#withdraw_using_check(amount)`: The input amount gets taken out of the account as a result of a check withdrawal. Returns the updated account balance.
  - Allows the account to go into overdraft up to -$10 but not any lower
  - The user is allowed three free check uses in one month, but any subsequent use adds a $2 transaction fee
- `#reset_checks`: Resets the number of checks used to zero
