class Expense < ActiveRecord::Base
  belongs_to :user

  validates :amount, numericality: { greater_than: 0 }
  validates :description, presence: true

  def self.total
    sum(:amount)
  end

  def self.by_date(date)
    where(created_at: date.beginning_of_month..date.end_of_month)
  end
end
