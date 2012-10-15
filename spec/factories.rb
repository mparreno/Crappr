FactoryGirl.define do
  factory :suburb do |s|
    s.name "Northland"
  end

  factory :toilet do |toilet|
    toilet.location ""
    toilet.lat ""
    toilet.lng ""
  end
end