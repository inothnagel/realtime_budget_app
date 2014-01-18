class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :accounts, :transactions

  has_and_belongs_to_many :accounts
  has_many :transactions
  has_many :recurs

  def display_string
    name = ""
    unless self.name.nil?
      name = self.name
    end

    name + " " + self.email

  end

  def name_or_email
    return name || email
  end

  def accounts_total
    self.accounts.map {|a| a.cash}.reduce(0, :+)
  end

  def budget_total
    self.accounts.map {|a| a.budget}.reduce(0, :+)
  end
end
