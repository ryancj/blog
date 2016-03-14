FactoryGirl.define do
  factory :post do
    association :user, factory: :user

    sequence(:name)   {|n| "#{Faker::Company.bs}-#{n}" }
    category_id       rand(10)
    body              { Faker::Lorem.paragraph }

  end
end
