class SetDefaultOnRecurDates < ActiveRecord::Migration
  def up
    change_column :recurs, :last_recur, :datetime, :default => Time.new(2000,01,01)

    Recur.all.each do |recur|
      if recur.last_recur.nil?
        recur.last_recur = Time.new(2000,01,01)
        recur.save
      end
    end
  end

  def down
  end
end
