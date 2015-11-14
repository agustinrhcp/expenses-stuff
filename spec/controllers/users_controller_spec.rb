require 'spec_helper'

describe UsersController do
	describe 'GET signup' do
		it 'renders the new view' do
			get :new

			expect(response).to render_template :new
		end
	end

	describe 'POST signup' do
		let(:password) { 'passwordo' }
		let(:user_attrs) do
			{
				email: 'email@gmail.com',
				password: password,
				password_confirmation: password
			}
		end

		it 'creates a new user' do
			expect {
				post :create, user: user_attrs
			}.to change { User.all.size }.by(1)
		end

		it 'logins the user' do
			expect {
				post :create, user: user_attrs
			}.to change { session[:user_id] }.from(nil)
		end
	end
end
