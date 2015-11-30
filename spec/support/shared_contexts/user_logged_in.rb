RSpec.shared_context 'user logged in' do

  let(:current_user) { FactoryGirl.create(:user) }

  before { session[:user_id] = current_user.id }
end
