FactoryBot.define do
  factory :link do
    lemma_from { build :lemma }
    lemma_to { build :lemma }
    type { build :link_type }
  end
end
