FactoryBot.define do
  factory :lemma_text do
    lemma
    text { Uniqid.id }
  end
end
