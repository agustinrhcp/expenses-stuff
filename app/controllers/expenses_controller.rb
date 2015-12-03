class ExpensesController < ApplicationController
  def index
    @date = sanitized_date || Date.today

    @expenses = current_user.expenses.by_date(@date)
  end

  def create
    expense_attrs = params.require(:expense).permit(:amount, :description)
    expense_attrs[:user_id] = current_user.id

    @expense = Expense.create(expense_attrs)

    if @expense.save

      redirect_to action: :index
    else
      flash.now[:error] = @expense.errors.full_messages

      index
      render action: :index
    end
  end

  private

  def sanitized_date
    if params[:year] && params[:month]
      Date.new(params[:year].to_i, params[:month].to_i)
    end
  rescue
    nil
  end
end
