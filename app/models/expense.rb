class Expense < ActiveRecord::Base

	validates :amount, numericality: {
    greater_than: 0,
    message: 'InvalidAmount - Amount attributes must be greater than zero'
  }
	validates :description, presence: {
		message: 'InvalidDescription - Description can\'t be blank'
	}
end
