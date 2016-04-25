class ExpensesController < ApplicationController
  def index
    @date = sanitized_date || Date.today
    @expense = Expense.new
    set_expenses
  end

  def create
    @expense = Expense.create(expense_attrs)
    @date = @expense.date || Date.today

    if @expense.save
      redirect_to action: :index, year: @date.year, month: @date.month
    else
      flash.now[:error] = @expense.errors.full_messages
      set_expenses
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
    params.require(:expense).permit(
      :amount, :description, :date, :tag, :installments, :applies_monthly
    )
  end

  def expense_attrs
    expenses_params.tap do |attr|
      attr[:user_id] = current_user.id
      attr[:applies_monthly] = attr[:applies_monthly] != '0'
    end
  end

  def set_expenses
    @expenses = current_user.expenses.by_date(@date)
  end
end
