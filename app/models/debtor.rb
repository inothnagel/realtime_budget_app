class Debtor < ActiveRecord::Base
  has_many :accounts
end
