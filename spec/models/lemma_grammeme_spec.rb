require 'rails_helper'

RSpec.describe Grammeme, type: :model do
  let(:lemma_grammeme) { create :grammeme }

  it('build') { expect(build(:lemma_grammeme, kind_id)).to be_valid() }
  it('create') { expect(create(:lemma_grammeme)).to be_valid() }

end
