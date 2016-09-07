FactoryGirl.define do
  factory :playlist do
    name 'EDM'
    user_id 1
    created_at DateTime.new(2016, 1, 2).in_time_zone
  end
end
