require 'spec_helper'

describe Transaction do

  describe "#abs_value" do
    it 'returns the absolute value of the transaction' do
      @transaction = Transaction.create(:value => 100)
      @transaction.abs_value.should == 100
      @transaction = Transaction.create(:value => -100)
      @transaction.abs_value.should == 100
    end
  end

  describe "#positive?" do
    it 'returns true if the transaction value is 0 or above' do
      @transaction = Transaction.create(:value => 100)
      @transaction.should be_positive
    end
    it 'returns false if the transaction value is below 0' do
      @transaction = Transaction.create(:value => -100)
      @transaction.should_not be_positive
    end
  end

  describe '#negative?' do
    it 'returns false if the transaction value is 0 or above' do
      @transaction = Transaction.create(:value => 100)
      @transaction.should_not be_negative
    end
    it 'returns true if the transaction value is below 0' do
      @transaction = Transaction.create(:value => -100)
      @transaction.should be_negative
    end
  end

  describe '#execute' do
    it 'should set datetime_executed to current time' do
      account = Account.create(:cash=>1000)
      transaction = account.transactions.create(:value=>100)
      transaction.datetime_executed.should eq(nil)
      transaction.execute
      transaction.datetime_executed.should be_present
    end
  end

  describe '#reverse' do
    it 'should return the amount back to the account that owns it' do
      @account = Account.create(:cash => 0)
      @transaction = @account.new_transaction(100, 'test')
      @transaction.execute
      @account.cash.should == -100
      @transaction.reverse
      @account.cash.should == 0
    end

    it 'should destroy itself after reversing'
  end

  describe '#record_days_delta_metric' do
    it 'should be called after creation' do
      @transaction = Transaction.new
      @transaction.should_receive(:record_days_delta_metric)
      @transaction.save!
    end
    
    it 'should create a new datapoint on the days delta metric with the correct value' do
      @account = Account.create(:cash=>-1000, :budget=>30000)
      @transaction = @account.transactions.create(:value=>10)

      @account.days_delta_metric.datapoints.count.should == 0
      @transaction.execute
      @account.days_delta_metric.datapoints.count.should == 1
      @account.days_delta_metric.datapoints.last.value.should == "-1"
    end
  end
end
