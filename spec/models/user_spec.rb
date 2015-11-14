require 'spec_helper'

describe User do
	describe 'validations' do
		context 'when the password confirmation does not match' do
			let(:password_confirmation) { 'imnotbatman' }

			it 'fails' do
				expect {
					FactoryGirl.create(:user, password_confirmation: password_confirmation)
				}.to raise_error(ActiveRecord::RecordInvalid)
			end
		end

		context 'when the password is too short' do
			let(:password) { 'batsy' }

			it 'fails' do
				expect {
					FactoryGirl.create(:user, password: password)
				}.to raise_error(ActiveRecord::RecordInvalid)
			end
		end

		context 'when the password is blank' do
			let(:password) { nil }

			it 'fails' do
				expect {
					FactoryGirl.create(:user, password: password)
				}.to raise_error(ActiveRecord::RecordInvalid)
			end
		end

		context 'when the email is blank' do
			let(:email) { '' }

			it 'fails' do
				expect {
					FactoryGirl.create(:user, email: email)
				}.to raise_error(ActiveRecord::RecordInvalid)
			end
		end

		context 'when the email is not unique' do
			let!(:user) { FactoryGirl.create(:user) }

			it 'fails' do
				expect {
					FactoryGirl.create(:user)
				}.to raise_error(ActiveRecord::RecordInvalid)
			end
		end
	end

	describe 'before save' do
		let(:user) { FactoryGirl.build(:user) }

		it 'creates a salt' do
			expect {
				user.save
			}.to change { user.salt }.from(nil)
		end

		it 'creates an encrypted password' do
			expect {
				user.save
			}.to change { user.encrypted_password }.from(nil)
		end
	end
end
