class SetMissingStartingCashValuesToZero < ActiveRecord::Migration
  def up
    Account.all.each do |account|
      if account.starting_cash.nil?
        account.starting_cash = 0
        account.save
      end
    end
  end

  def down
  end
end
