class AddWeeksToDivisions < ActiveRecord::Migration
  def change
    add_column :divisions, :num_weeks, :int
    add_column :divisions, :start_date, :date
  end
end
