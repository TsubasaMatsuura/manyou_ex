FactoryBot.define do
  factory :user do
    name { 'sample' }
    email { 'sample@example.com' }
    password { '00000000' }
    admin { "false" }
  end
  factory :admin_user, class: User do
    name { 'admin2' }
    email { 'admin2@example.com' }
    password { '00000000' }
    admin { "true" }
  end
end