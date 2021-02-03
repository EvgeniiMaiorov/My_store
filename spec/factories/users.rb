FactoryGirl.define do
    factory :user do
        login "login"
        # password "password"
        # sequence(:email) { |i| "email#{i}@mail.com" }
    end
end