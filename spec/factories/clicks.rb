FactoryBot.define do
  factory :click do
  	count 0
  	ip_address "127.0.0.1"
  	country "india"
  	association :link
  end
end
