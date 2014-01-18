desc "This task is called by the Heroku scheduler add-on"

task :daily_tasks => :environment do
  daily_email
  debtor_emails
  run_recurs
  add_daily_budget
end

task :add_daily_budget => :environment do
  add_daily_budget
end

task :daily_email => :environment do
  daily_email
end

task :debtor_emails => :environment do
  debtor_emails
end

task :run_recurs => :environment do
  run_recurs
end

def add_daily_budget
  puts "Adding daily budget"
  Account.all.each { |a| a.add_daily_budget }
  puts "Done adding daily budget"  
end

def daily_email
  puts "Sending daily email."
  Account.all.each { |a| a.send_daily_email }
  puts "Done sending daily email."
end

def run_recurs
  puts "Running Recurs"
  Recur.all.each do |recur|
    if recur.execute?
      puts "Executing recur: " + recur.name
      recur.execute
    end
  end
  puts "Finished running Recurs"
end

def debtor_emails
  puts "Sending Debtor Emails."

  if Time.new.wday == 1
    puts "Debtor emails will send because it is monday."
    Debtor.all.each do |debtor|
      debtor.accounts.each do |account|
        UserMailer.debtor_account_email(account).deliver
      end
    end
  else
    puts "Debtors emails will not send because it is not monday."
  end

  puts "Done sending debtor emails."
end