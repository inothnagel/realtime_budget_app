class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :recur

  attr_accessible :user, :account, :account_value, :cash, :value, :description, :executed, :datetime_executed

  after_create :record_days_delta_metric

  def counts_as_expense?
    self.negative? && self.executed?
  end

  def reverse
    self.account.cash += self.value * -1
    self.account.save
    add_days_delta_metric
    self.destroy
  end

  def abs_value
    self.value.abs
  end

  def positive?
    self.value >= 0
  end

  def negative?
    self.value < 0
  end

  def date_string
    if self.datetime_executed.nil?
      return "None"
    end
    self.datetime_executed.strftime('%m/%d/%Y')
  end

  def execute
    raise 'transaction value cannot be nil' if self.value.nil?
    raise 'account cash cannot be nil' if self.account.cash.nil?

    save
    reload

    account.cash += self.value
    self.executed = true
    self.datetime_executed = Time.now
    self.account_value = account.cash
    account.save
    add_days_delta_metric
    save
  end

  def add_days_delta_metric
    account.days_delta_metric.add_datapoint(self.created_at, account.days_delta)
  end

  def user_email
    if self.user.nil?
      return "None"
    else
      return self.user.email
    end
  end

  def record_days_delta_metric

  end
end
