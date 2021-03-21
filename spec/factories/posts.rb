FactoryBot.define do
  factory :post do
    body { 'Some cool content' }
    user { create(:user, :valid) }
  end
end
