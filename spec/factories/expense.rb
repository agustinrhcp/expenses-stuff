FactoryGirl.define do
  factory :expense do
    amount      { rand(1..1_000) }
    description 'Food'
  end

  trait :monthly do
    applies_monthly true
  end
end
