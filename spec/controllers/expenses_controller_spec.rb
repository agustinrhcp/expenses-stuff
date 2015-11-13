require 'spec_helper'

require 'factories/expense'

describe ExpensesController do
	describe 'index' do

		let(:expense) { FactoryGirl.create(:expense) }

		it 'assigns the expenses to expenses' do
			get :index

			expect(assigns[:expenses]).to include expense
		end

		it 'renders the index view' do
			get :index

			expect(response).to render_template :index
		end
	end

	describe 'create' do
		let(:expense_attrs) {{ amount: rand(1_000), description: 'Something' }}

		it 'creates a new expense' do
			expect {
				post :create, expense: expense_attrs
			}.to change { Expense.all.size }.by(1)
		end

		it 'redirects to index' do
			post :create, expense: expense_attrs

			expect(response).to redirect_to action: :index
		end
	end
end
