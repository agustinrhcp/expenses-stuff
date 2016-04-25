class AddInstallmentsToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :installments, :integer
    add_column :expenses, :end_date, :date
  end
end
