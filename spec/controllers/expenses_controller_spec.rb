require 'spec_helper'

require 'factories/expense'

describe ExpensesController do
  include_context 'user logged in'

  describe 'index' do
    let!(:expense) { FactoryGirl.create(:expense, user: current_user) }
    let!(:monthly_expense) do
      FactoryGirl.create(
        :expense, :monthly, created_at: 6.months.ago, user: current_user
      )
    end

    it 'renders the index view' do
      get :index
      expect(response).to render_template :index
    end

    describe '@expenses' do
      subject { get :index; assigns(:expenses) }

      it { is_expected.to include expense }
      it { is_expected.to include monthly_expense}
    end

    describe '@date' do
      let(:params) { {} }
      subject { get :index, params; assigns(:date) }

      it { is_expected.to eql Date.today }

      context 'when year and month params are given' do
        let(:next_month)  { Date.today.next_month }
        let(:params)      {{ year: next_month.year, month: next_month.month }}

        its(:year)  { is_expected.to eql next_month.year }
        its(:month) { is_expected.to eql next_month.month }
      end
    end
  end

  describe 'create' do
    let(:expense_attrs) {{ amount: rand(0..1_000), description: 'Something', tag: 'Tag' }}

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
      its(:tag)         { is_expected.to eql expense_attrs[:tag] }
    end

    it 'redirects to index' do
      post :create, expense: expense_attrs
      expect(response).to redirect_to action: :index
    end

    context 'when it fails' do
      let!(:expense) { FactoryGirl.create(:expense, user: current_user) }

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

  describe 'destroy' do
    let!(:expense) { FactoryGirl.create(:expense) }

    it 'destroys the expense' do
      expect {
        delete :destroy, id: expense.id
      }.to change { Expense.count }.by(-1)
    end

    it 'redirects to index' do
      delete :destroy, id: expense.id
      expect(response).to redirect_to action: :index
    end
  end
end
