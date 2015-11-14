require 'spec_helper'

describe SessionsController do
	describe 'GET login' do
		it 'renders the new view' do
			get :new

			expect(response).to render_template :new
		end
	end

	describe 'POST login' do
		let(:password) { 'passwordo' }
		let(:user) { FactoryGirl.create(:user, password: password) }
		let(:auth) { { email: user.email, password: password } }

		it 'redirets to expenses index' do
			post :create, auth: auth

			expect(response).to redirect_to expenses_path
		end

		it 'logins the user' do
			expect {
				post :create, auth: auth
			}.to change { session[:user_id] }.from(nil).to(user.id)
		end
	end
end
