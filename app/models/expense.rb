class Expense < ActiveRecord::Base
  belongs_to :user

  validates :amount, numericality: { greater_than: 0 }
  validates :description, presence: true

  scope :applies_monthly?, -> { where(applies_monthly: true) }
  scope :from_month, ->(date) do
    where(date: date.beginning_of_month..date.end_of_month)
  end

  def self.total
    sum(:amount)
  end

  def self.by_date(date)
    #HACK .or.where() does not exist yet :(
    Expense.where(
      "#{applies_monthly?.to_sql.split('WHERE').last}" +
      ' OR ' +
      "#{from_month(date).to_sql.split('WHERE').last}"
    )
  end
end
