FactoryGirl.define do
  factory :suburb do |s|
    s.name "Northland"
  end

  factory :toilet do |toilet|
    toilet.location ""
    toilet.lat ""
    toilet.lng ""
  end

  factory :review do |r|
    r.name "Tester"
    r.value 3
    r.association(:toilet)
  end
end