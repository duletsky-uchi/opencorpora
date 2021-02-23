require 'rails_helper'

RSpec.describe LemmaGrammeme, type: :model do
  let(:grammeme) { create :grammeme }
  let(:lemma_form) { create :lemma_form }
  let(:lemma_grammeme) { create :lemma_grammeme, kind_id: lemma_form.id, grammeme_id: grammeme.id }

  it('build') { expect(build(:lemma_grammeme)).to be_valid() }
  it('create') { expect(lemma_grammeme).to be_valid() }

end
