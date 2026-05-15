FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "Test@123" }
    password_confirmation { "Test@123" }

    confirmed_at { Time.current }
    failed_attempts { 0 }

    locked_at { nil }

    sign_in_count { 0 }
    current_sign_in_at { nil }
    last_sign_in_at { nil }
  end
  
  factory :unconfirmed_user, parent: :user do
    confirmed_at { nil }
  end
  factory :locked_user, parent: :user do
    locked_at { Time.current }
  end
end
