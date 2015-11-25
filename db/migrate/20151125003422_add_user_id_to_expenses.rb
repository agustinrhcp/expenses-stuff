class AddUserIdToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :user_id, :integer
    add_foreign_key :expenses, :users
  end
end
