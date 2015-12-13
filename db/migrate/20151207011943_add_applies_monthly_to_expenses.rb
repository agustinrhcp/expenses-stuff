class AddAppliesMonthlyToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :applies_monthly, :boolean
  end
end
