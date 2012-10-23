FactoryGirl.define do
  factory :suburb do |s|
    s.name "Northland"
  end

  factory :toilet do |t|
    t.name "Test Toilet"
    t.location "Northland, Wellington"
    t.lat -41.283225
    t.lng 174.75762
  end


  factory :review do |r|
    r.name "Tester"
    r.value 3
    r.association(:toilet)
  end
end