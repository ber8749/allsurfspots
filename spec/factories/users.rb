FactoryGirl.define do
  factory :user do
    name  'Joe Blow'
    email 'joe@blow.com'
    role  ''
    password 'ABCD1234s'

    trait :admin do
      role 'admin'
    end
  end
end
