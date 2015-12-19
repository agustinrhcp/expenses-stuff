class ExpensesController < ApplicationController
  def index
    @date = sanitized_date || Date.today

    @expenses = current_user.expenses.by_date(@date)
    @expense ||= Expense.new
  end

  def create
    expense_attrs = expenses_params
    expense_attrs[:user_id] = current_user.id

    @expense = Expense.create(expense_attrs)

    if @expense.save
      redirect_to action: :index
    else
      flash.now[:error] = @expense.errors.full_messages

      index
      render :index
    end
  end

  def destroy
    Expense.find(params[:id]).destroy

    redirect_to action: :index
  end


  private

  def sanitized_date
    if params[:year] && params[:month]
      Date.new(params[:year].to_i, params[:month].to_i)
    end
  rescue
    nil
  end

  def expenses_params
    params.require(:expense).permit(:amount, :description, :applies_monthly, :tag)
  end
end
