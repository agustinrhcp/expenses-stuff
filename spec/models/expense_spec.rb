require 'spec_helper'

describe Expense do
  describe 'validations' do
    context 'when the amount is not a number' do
      let(:amount) { 'two' }

      it 'fails' do
        expect {
          FactoryGirl.create(:expense, amount: amount)
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when the amount is less than zero' do
      let(:amount) { -100 }

      it 'fails' do
        expect {
          FactoryGirl.create(:expense, amount: amount)
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when the description is blank' do
      let(:description) { nil }

      it 'fails' do
        expect {
          FactoryGirl.create(:expense, description: description)
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '.total' do
    let!(:expense1) { FactoryGirl.create(:expense) }
    let!(:expense2) { FactoryGirl.create(:expense) }

    it 'returns the total of the expenses' do
      expect(Expense.all.total).to be expense1.amount + expense2.amount
    end
  end

  describe '.by_date' do
    subject { Expense.by_date(this_month_date) }

    let(:this_month_date)      { Date.today }
    let!(:this_month_expense)  { FactoryGirl.create(:expense) }
    let!(:other_month_expense) { FactoryGirl.create(:expense, created_at: Date.today << 6) }

    it { is_expected.to include this_month_expense }
    it { is_expected.to_not include other_month_expense }
  end
end
