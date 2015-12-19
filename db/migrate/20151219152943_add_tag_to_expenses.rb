class AddTagToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :tag, :string
  end
end
