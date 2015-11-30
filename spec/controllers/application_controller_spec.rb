require 'spec_helper'

describe ApplicationController, :type => :controller do
  controller do
    def index
      render text: 'OK'
    end
  end

  describe 'logged_in?' do
    subject { controller.logged_in? }

    context 'when the user is logged in' do
      include_context 'user logged in'

      it { is_expected.to be true }
    end

    context 'when the user is not logged in' do
      it { is_expected.to be false }
    end
  end

  describe 'current_user' do
    include_context 'user logged in'

    subject { controller.current_user }

    it { is_expected.to eql current_user }
  end

  describe 'require_login' do
    context 'when the user is logged in' do
      include_context 'user logged in'

      it 'allows navigation' do
        get :index

        expect(response.body).to eq 'OK'
      end
    end

    context 'when the user is not logged in' do
      it 'redirects to new sessions path' do
        get :index

        expect(response).to redirect_to login_path
      end
    end
  end
end
