FactoryGirl.define do
  factory :expense do
    amount      { rand(1..1_000) }
    description 'Sandwich'
    date        { Date.today }
    tag         'Food'
  end

  trait :monthly do
    applies_monthly true
  end
end
