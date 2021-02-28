FactoryBot.define do
  factory :restriction do
    left_type { 'lemma' }
    left_grammeme { build :grammeme }
    right_type { 'lemma' }
    right_grammeme { build :grammeme }
    auto { false }
    typ { 'maybe' }
  end
end
