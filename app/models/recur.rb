class Recur < ActiveRecord::Base
  has_many :transactions
  belongs_to :account
  belongs_to :user

  def account_display_string
    if self.account.nil?
      return "None"
    else
      return self.account.display_string
    end
  end

  # checks if this recur is due today, and executes it if so
  def due_today?
    current_day = Time.now.day
    due_days_string = self.recur_days.split ","
    due_days_int = due_days_string.map { |day_s| day_s.to_i }
    return due_days_int.include? current_day
  end

  def executed_today?
    last_recur_date = self.last_recur.to_date
    current_date = Time.now.to_date
    if last_recur_date == current_date
      return true
    else
      return false
    end
  end

  # makes a new transaction, used when the recur is due
  def execute
    transaction = Transaction.new
    transaction.recur = self
    transaction.account = self.account
    transaction.user = self.user
    transaction.value = self.value
    transaction.description = "Recur: " + self.name

    transaction.save
    transaction.execute

    update_last_recur
    send_recur_email
  end

  # Informs the recur owner via email of a recur execution
  def send_recur_email
    UserMailer.recur_announcement(self).deliver
  end

  def update_last_recur
    self.last_recur = Time.now
    self.save
  end

  # returns true if the recur should be executed now
  def execute?
    if !self.due_today?
      return false
    end

    if self.executed_today?
      return false
    end

    return true
  end
end
