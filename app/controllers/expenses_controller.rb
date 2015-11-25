class ExpensesController < ApplicationController
  def index
    assign_user_expenses
  end

  def create
    expense_attrs = params[:expense].permit(:amount, :description)
    expense_attrs[:user_id] = current_user.id

    @expense = Expense.create(expense_attrs)

    if @expense.save
      redirect_to action: :index
    else
      flash.now[:error] = @expense.errors.full_messages

      assign_user_expenses

      render action: :index
    end
  end

  private

  def assign_user_expenses
    @expenses = current_user.expenses
  end
end
