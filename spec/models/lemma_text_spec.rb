require 'rails_helper'

RSpec.describe LemmaText, type: :model do
  let(:lemma_text) { create :lemma_text }

  it('build') { expect(build(:lemma_text)).to be_valid() }
  it('create') { expect(create(:lemma_text)).to be_valid() }

end
