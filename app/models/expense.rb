class Expense < ActiveRecord::Base
  belongs_to :user

  validates :amount, numericality: { greater_than: 0 }
  validates :description, presence: true

  scope :applies_monthly?, -> { where(applies_monthly: true) }
  scope :created_at, ->(date) do
    where(created_at: date.beginning_of_month..date.end_of_month)
  end

  def self.total
    sum(:amount)
  end

  def self.by_date(date)
    # v HACK .or.where() does not exist yet :(
    (applies_monthly? + created_at(date)).uniq
  end
end
