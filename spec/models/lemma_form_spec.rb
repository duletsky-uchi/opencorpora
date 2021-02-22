require 'rails_helper'

RSpec.describe LemmaForm, type: :model do
  let(:lemma_form) { create :lemma_form }

  it('build') { expect(build(:lemma_form)).to be_valid() }
  it('create') { expect(create(:lemma_form)).to be_valid() }

end
