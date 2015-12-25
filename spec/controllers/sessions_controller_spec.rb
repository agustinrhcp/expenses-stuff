require 'spec_helper'

describe SessionsController do
  describe 'GET login' do
    it 'renders the new view' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST login' do
    let(:password)    { 'passwordo' }
    let(:user)        { FactoryGirl.create(:user, password: password) }
    let(:user_params) {{ email: user.email, password: password }}

    it 'redirects to expenses index' do
      post :create, user: user_params
      expect(response).to redirect_to expenses_path
    end

    it 'logins the user' do
      expect {
        post :create, user: user_params
      }.to change { session[:user_id] }.from(nil).to(user.id)
    end

    context 'when the user or password does not match' do
      before { user_params[:email] += 'nope' }

      it 'renders the new view' do
        post :create, user: user_params
        expect(response).to render_template :new
      end

      it 'shows an error message' do
        post :create, user: user_params
        expect(flash[:error]).to be
      end
    end
  end

  describe 'DELETE logout' do
    include_context 'user logged in'
    it 'logout the user' do
      expect {
        post :destroy
      }.to change { session[:user_id] }.from(current_user.id).to(nil)
    end
  end
end
