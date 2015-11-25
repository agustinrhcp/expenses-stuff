require 'spec_helper'

require 'factories/expense'

describe ExpensesController do
  include_context 'user logged in'

  describe 'index' do
    let(:expense) { FactoryGirl.create(:expense, user: current_user) }

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

    describe 'the created expense' do
      subject { post :create, expense: expense_attrs; Expense.last }

      its(:user)        { is_expected.to eql current_user }
      its(:amount)      { is_expected.to eql expense_attrs[:amount] }
      its(:description) { is_expected.to eql expense_attrs[:description] }
    end

    it 'redirects to index' do
      post :create, expense: expense_attrs

      expect(response).to redirect_to action: :index
    end

    context 'when it fails' do
      let(:expense) { FactoryGirl.create(:expense, user: current_user) }

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
