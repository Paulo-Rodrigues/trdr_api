FactoryBot.define do
  factory :user do
    trait :valid do
      email { 'valid_user@email.com' }
      password { 'password' }
    end

    trait :invalid do
      email { 'invalid_email' }
      password { '123' }
    end
  end
end
