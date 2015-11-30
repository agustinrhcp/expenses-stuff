class Expense < ActiveRecord::Base
  belongs_to :user

  validates :amount, numericality: { greater_than: 0 }
  validates :description, presence: true

  def self.total
    sum(:amount)
  end
end
