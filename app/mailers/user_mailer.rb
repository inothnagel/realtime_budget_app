class UserMailer < ActionMailer::Base
  default from: "Fintrack"

  def daily_email
    @account ||= Account.find(1)
    emails = @account.user_emails
    mail(:to => emails, :subject => "Fintrack: #{@account.ahead_or_behind_message}")
  end

  def debtor_email(debtor)
    @debtor = debtor
    @accounts = debtor.accounts
    mail(:to => debtor.email, :subject => "Fintrack")
  end

  def debtor_account_email(account)
    @account = account
    @debtor = account.debtor
    @total_due = account.cash
    @due_now = account.cash / 6
    mail(:to => @debtor.email, :subject => "Fintrack: Please pay R#{@due_now}")
  end

  def recur_announcement(recur)
    @recur = recur
    @account = recur.account
    mail(:to => recur.user.email, :subject => "Fintrack: Recur Executed")
  end

  def transaction_email(current_user, transaction)
    @transaction = transaction
    @account = @transaction.account
    emails = @account.user_emails
    @user =  current_user
    mail(:to => emails, :subject => "#{@account.name}: #{transaction.value} - #{transaction.description}: ")
  end
end
