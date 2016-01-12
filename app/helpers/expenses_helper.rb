module ExpensesHelper
  def next_month_path(date)
    next_month = date.next_month
    expenses_path(year: next_month.year, month: next_month.month)
  end

  def previous_month_path(date)
    prev_month = date.prev_month
    expenses_path(year: prev_month.year, month: prev_month.month)
  end

  def installments_desc(expense, date)
    if expense.installments
      current_installment = coso_mocho(expense.date, date) + 1
      ' ' + current_installment.to_s + '/' + expense.installments.to_s
    else
      ''
    end
  end

  def coso_mocho(date1, date2)
    (date2.year * 12 + date2.month) - (date1.year * 12 + date1.month)
  end
end
