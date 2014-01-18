class Account < ActiveRecord::Base
  has_many :transactions
  has_many :recurs
  has_many :metrics
  has_and_belongs_to_many :users
  belongs_to :debtor
  belongs_to :split_account, :class_name => "Account", :foreign_key => :split_account_id

  def transactions_for(date)
    self.transactions.where('created_at > ?', date - 1.day).where('created_at < ?', date + 1.day)
  end

  def total_spent_on(date)
    transactions = transactions_for(date)
    total = 0
    transactions.each do |transaction|
      total += transaction.abs_value if transaction.counts_as_expense?
    end
    total
  end

  def user_saved_on?(date)
    total_spent_on(date) < daily_budget
  end

  def current_streak
    date = Date.today
    count = 0

    while user_saved_on?(date) do
      count += 1
      date -= 1.day
    end

    count
  end

  def new_transaction(value, description)
    t = self.transactions.create
    t.account = self
    t.value = value
    t.description = description
    t.save
    t.reload
    t
  end

  def line_chart_data
    GoogleLineChart.new.data_for(self.days_delta_metric.datapoints)
  end

  def days_delta_metric
    metrics.find_or_create_by_label(:days_delta)
  end

  def last_weeks_transactions
    transactions.order(:datetime_executed).reverse_order.where("created_at > ?", 7.days.ago)
  end

  def overspent_today?
    cash_spent_today > daily_budget
  end

  def cash_delta_today
    cash_spent_today - daily_budget
  end

  def cash_spent_today
    total = 0
    transactions_today.each do |transaction| 
      total += transaction.abs_value if transaction.counts_as_expense?
    end
    total
  end

  def transactions_today
    transactions.where('created_at > ?', Date.today)
  end

  def over_or_under_budget_message
    if overspent_today?
      "You spent #{cash_delta_today} over budget today"
    else
      "You spent #{cash_delta_today.abs} under budget today"
    end
  end

  def add_daily_budget
    message = "Daily Budget"
    daily_amount = self.daily_budget

    # user takes a 10% knock on their daily budget if they are behind
    unless self.ahead?
      daily_amount = daily_amount * (100 - penalty_percentage) / 100

      if penalty_percentage > 0
        message += " - #{penalty_percentage}% penalty for being behind."
      end
    end

    self.new_transaction(daily_amount, message).execute
  end

  # returns 0-100, the percentage penalty the user takes on his daily budget
  # because of being in overdraft. User gets a 1% penalty for every R20 behind,
  # capped at 50%
  def penalty_percentage
    return 0 if ahead?
    amount = cash.abs
    percentage = amount / 20
    percentage = 50 if percentage > 50
    percentage
  end

  def days_ahead_or_behind
    return 0 if cash == 0 || daily_budget == 0
    cash / daily_budget
  end

  def days_delta
    days_ahead_or_behind
  end

  def ahead?
    self.cash >= 0
  end

  def daily_budget
    return 0 if budget.nil? || budget == 0
    budget / 30
  end

  # Returns true if this account is attached to a debtor
  def debtor_account?
    return self.debtor!=nil
  end

  def cash_per_day
    days_left = self.days_left
    cash_per_day = (self.cash/days_left).to_i
  end

  def cash_per_day_per_person(number_of_people)
    days_left = self.days_left
    cash_per_day = self.cash / days_left
    cash_per_day = (cash_per_day / number_of_people) unless cash_per_day == 0
    cash_per_day.to_s
  end

  def cash_supposed
    days_left = self.days_left
    cash_supposed = self.starting_cash / 30 * days_left
  end

  def days_left
    next_month = Date.new(Time.now.year,Time.now.month,-1)
    days_left = (next_month - Date.today).to_i
  end

  def cash_supposed_per_day
    cash_supposed = self.cash_supposed
    cash_supposed_per_day = cash_supposed / 30
  end

  # returns the deviation between where the account should be, and where it is.
  def cash_difference
    cash_supposed = self.cash_supposed
    cash_difference = self.cash - cash_supposed
  end

  def display_string
    self.name
  end

  # returns an array of emails of all the users that this account belongs to
  def user_emails
    emails = []
    users.each do |user|
      emails.push(user.email)
    end
    return emails
  end

  def send_daily_email
    # not implemented at the moment
  end
end
