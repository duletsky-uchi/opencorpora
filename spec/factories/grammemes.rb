FactoryBot.define do
  factory :grammeme do
    name { Uniqid.id }
    parent { 'parent' }
    description { 'description' }
    add_attribute(:alias) { '' }
  end
end
