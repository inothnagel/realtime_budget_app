require 'spec_helper'

describe Account do

  describe 'transactions_for' do
    it 'returns the transactions for a given date' do
      @account = Account.create(:cash => 0)
      @transaction_1 = @account.transactions.create(:value => -200)
      @transaction_1.created_at = Date.today - 1.days
      @transaction_1.account = @account
      @transaction_1.save

      @transaction_2 = @account.transactions.create(:value => -200)
      @transaction_2.account = @account
      @transaction_2.save


      @account.transactions_for(Date.today).should include(@transaction_2)
      @account.transactions_for(Date.today).should_not include(@transaction_1)

      @account.transactions_for(Date.today - 1.days).should_not include(@transaction_2)
      @account.transactions_for(Date.today - 1.days).should include(@transaction_1)
    end
  end

  describe 'total_spent_on' do
    it 'should return the total amount spent on a given date' do
      @account = Account.create(:cash => 0)
      @transaction_1 = @account.transactions.create(:value => -100)

      @transaction_2 = @account.transactions.create(:value => -200)
      @transaction_2.created_at = Date.today - 1.days
      @transaction_2.save

      @transaction_1.execute
      @transaction_2.execute

      @account.total_spent_on(Date.today).should == 100
      @account.total_spent_on(Date.today - 1.days).should == 200
    end
  end

  describe '#user_saved_on?' do
    it 'returns true if the user spent less money than their budget on the given date' do
      @account = Account.create(:cash => 0)
      @transaction = @account.transactions.create(:value => 0)
      @account.stub(:daily_budget).and_return(100)
      @account.user_saved_on?(Date.today).should be_true
    end

    it 'returns false if the user spent more money than their budget on the given date' do
      @account = Account.create(:cash => 0)
      @transaction = @account.transactions.create(:value => -101)
      @transaction.account = @account
      @transaction.execute
      @transaction.save
      @account.stub(:daily_budget).and_return(100)
      @account.user_saved_on?(Date.today).should be_false
    end
  end

  describe '#current streak' do
    it 'returns the number of days you were under budget' do
      @account = Account.create(:cash => 0)
      @account.stub(:user_saved_on?).and_return(true,true,false)
      @account.current_streak.should == 2
    end
  end

  describe '#new_transaction' do
    before :each do 
      @account = Account.create(:cash => 100)
      @transaction = @account.new_transaction(10, 'hello')
    end

    it 'creates a new transaction' do
      @transaction.should be_kind_of(Transaction)
    end

    it 'sets the value of the transaction' do
      @transaction.value.should == 10
    end

    it 'sets the description of the transaction' do
      @transaction.description.should == 'hello'
    end

    it 'does not execute the transaction' do
      @transaction.should_not be_executed
    end
  end

  describe '#add_daily_budget' do
    it 'creates a transaction instead of just changing the cash value' do
      account = Account.create(:cash => 100)
      account.stub(:daily_budget).and_return(123)

      account.add_daily_budget

      transaction = account.transactions.last
      transaction.should_not be_nil
      transaction.value.should == account.daily_budget
      transaction.should be_executed
    end

    it 'adds the correct amount'
  end

  describe '#line_chart_data' do
    it 'returns the correct line chart data' do
      pending

      dates = [Time.now, Time.now - 1.day, Time.now - 2.days]
      amounts = [-10, 0, 10]

      correct_data = [
        [dates[0].to_s, "-10"],
        [dates[1].to_s, "0"],
        [dates[2].to_s, "10"]
      ]

      account = Account.create
      (0..2).each do |i|
        account.days_delta_metric.add_datapoint(dates[i], amounts[i])
      end

      account.line_chart_data.should == correct_data
    end
  end

  describe '#cash_spent_today' do
    before :each do
      @account = Account.create(:cash=>0)
    end

    it 'only counts transactions that have been executed' do
      @transaction = @account.transactions.create(:value => -100)
      @account.cash_spent_today.should == 0
      @transaction.execute
      @account.cash_spent_today.should == 100
    end

    it 'does not count transactions that have been reversed' do
      pending

      @transaction = @account.new_transaction(100, 'test')
      @transaction.execute
      @account.cash_spent_today.should == 100
      @transaction.reverse
    end

    it 'only counts negative transactions' do
      @account.cash_spent_today.should == 0
      @transaction = @account.new_transaction(100, 'test').execute
      @account.cash_spent_today.should == 0
      @transaction = @account.new_transaction(-100, 'test').execute
      @account.cash_spent_today.should == 100
    end
  end

  describe '#days_delta_metric' do
    it 'should create the metric if it does not exist'
  end

  describe "#over_or_under_budget_message" do
    it 'returns the correct message when you are under budget' do
      account = Account.create!
      account.stub(:daily_budget).and_return(100)
      account.stub(:cash_spent_today).and_return(50)
      account.over_or_under_budget_message.should eq("You spent 50 under budget today")
    end

    it 'returns the correct message when you are over budget' do
      account = Account.create!
      account.stub(:daily_budget).and_return(100)
      account.stub(:cash_spent_today).and_return(150)
      account.over_or_under_budget_message.should eq("You spent 50 over budget today")
    end
  end

  describe "#last_weeks_transactions" do
    before :each do
      @account = Account.create
      @new_transaction = @account.transactions.create
      @old_transaction = @account.transactions.create
      @old_transaction.created_at = 8.days.ago
      @old_transaction.save!
    end

    it 'should return transactions from the past seven days' do
      @account.last_weeks_transactions.should include(@new_transaction)
    end

    it 'should not return transactions older than 7 days' do
      @account.last_weeks_transactions.should_not include(@old_transaction)
    end
  end
end
