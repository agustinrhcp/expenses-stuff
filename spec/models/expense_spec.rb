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
end
