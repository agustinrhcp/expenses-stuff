class Expense < ActiveRecord::Base

	validates :amount, numericality: { greater_than: 0 }
	validates :description, presence: true
end
