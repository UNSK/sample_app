FactoryGirl.define do
  factory :user do
    name "foobar"
    email "foo@bar.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
