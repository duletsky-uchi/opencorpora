FactoryBot.define do
  factory :lemma do
    lemma_id { Uniqid.p }
    rev { Uniqid.p }
  end
end
