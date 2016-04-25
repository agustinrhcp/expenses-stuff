require 'spec_helper'

describe Expense do
  describe 'validations' do
    subject { expense.valid? }

    let(:expense) { FactoryGirl.build(:expense) }

    it { is_expected.to be true }

    context 'when the amount is not a number' do
      before { expense.amount = 'two' }

      it { is_expected.to be false }
    end

    context 'when the amount is less than zero' do
      before { expense.amount = -100 }

      it { is_expected.to be false }
    end

    context 'when the description is blank' do
      before { expense.description = nil }

      it { is_expected.to be false }
    end
  end

  describe '.total' do
    let!(:expense1) { FactoryGirl.create(:expense) }
    let!(:expense2) { FactoryGirl.create(:expense) }

    it 'returns the total of the expenses' do
      expect(Expense.all.total).to eql (expense1.amount + expense2.amount)
    end
  end

  describe '.from_month' do
    subject { Expense.from_month(this_month_date) }

    let(:this_month_date)      { Date.today }
    let!(:this_month_expense)  { FactoryGirl.create(:expense) }
    let!(:other_month_expense) { FactoryGirl.create(:expense, date: Date.today << 6) }

    it { is_expected.to include this_month_expense }
    it { is_expected.to_not include other_month_expense }
  end

  describe '.applies_monthly?' do
    subject { Expense.applies_monthly?(Date.today) }

    let!(:every_month_expense) { FactoryGirl.create(:expense, applies_monthly: true) }
    let!(:regular_expense)     { FactoryGirl.create(:expense) }

    it { is_expected.to include every_month_expense }
    it { is_expected.to_not include regular_expense }
  end

  describe '.before_save' do
    context 'when the expense has installments' do
      let(:installments) { rand(10) }
      let(:expense) { FactoryGirl.build(:expense, installments: installments) }

      it 'sets the end date' do
        expect {
          expense.save
          expense.reload
        }.to change { expense.end_date }.to((expense.date >> installments - 1).end_of_month)
      end
    end
  end
end
