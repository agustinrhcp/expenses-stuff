module ExpensesHelper
  def next_month_path(date)
    next_month = date.next_month
    expenses_path(year: next_month.year, month: next_month.month)
  end

  def previous_month_path(date)
    prev_month = date.prev_month
    expenses_path(year: prev_month.year, month: prev_month.month)
  end
end
