FactoryGirl.define do
  factory :user do
    name  'Joe Blow'
    email 'joe@blow.com'
    role  ''

    trait :admin do
      role 'admin'
    end
  end
end
