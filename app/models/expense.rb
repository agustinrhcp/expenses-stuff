class Expense < ActiveRecord::Base
  belongs_to :user

  before_save :set_end_date

  validates :amount, numericality: { greater_than: 0 }
  validates :description, presence: true

  scope :applies_monthly?, ->(date) do
    where(applies_monthly: true).where('date < ?', date.end_of_month)
  end

  scope :from_month, ->(date) do
    where(date: date.beginning_of_month..date.end_of_month)
  end

  scope :installments_by_month, ->(date) do
    where.not(installments: nil).where(
      'date < ? AND end_date > ?', date.end_of_month, date.beginning_of_month
    )
  end

  def self.total
    sum(:amount)
  end

  def self.by_date(date)
    #HACK .or.where() does not exist yet :(
    Expense.where(
      "#{extract_where_clause(applies_monthly?(date))}" +
      ' OR ' +
      "#{extract_where_clause(from_month(date))}" +
      ' OR ' +
      "#{extract_where_clause(installments_by_month(date))}"
    )
  end

  private

  def set_end_date
    self.end_date = (date >> installments - 1).end_of_month if installments
  end

  def self.extract_where_clause(scope)
    scope.to_sql.split('WHERE').last
  end
end
