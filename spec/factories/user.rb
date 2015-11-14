FactoryGirl.define do
	factory :user do
		email   							'batman@gmail.com'
    password							'iambatman'
		password_confirmation { password }
	end
end
