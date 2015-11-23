require 'spec_helper'

require 'factories/expense'

describe ExpensesController do
  before { login_user }

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
    let(:expense_attrs) { { amount: rand(0..1_000), description: 'Something' } }

    it 'creates a new expense' do
      expect {
        post :create, expense: expense_attrs
      }.to change { Expense.all.size }.by(1)
    end

    it 'redirects to index' do
      post :create, expense: expense_attrs

      expect(response).to redirect_to action: :index
    end

    context 'when it fails' do
      let(:expense) { FactoryGirl.create(:expense) }

      before { expense_attrs.delete(:amount) }

      it 'renders the index view' do
        post :create, expense: expense_attrs

        expect(response).to render_template :index
      end

      it 'assigns expenses to expenses' do
        post :create, expense: expense_attrs

        expect(assigns[:expenses]).to include expense
      end

      it 'flashes error messages' do
        post :create, expense: expense_attrs

        expected = I18n.t('activerecord.errors.models.expense.attributes.amount.not_a_number')
        expect(flash[:error]).to include expected
      end
    end
  end
end
