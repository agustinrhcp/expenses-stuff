class ExpensesController < ApplicationController
  def index
    @expenses = Expense.all
  end

  def create
    expense_attrs = params[:expense].permit(:amount, :description)

    @expense = Expense.create(expense_attrs)

    if @expense.save
      redirect_to action: :index
    else
      flash[:error] = @expense.errors.full_messages

      @expenses = Expense.all

      render action: :index
    end
  end
end
