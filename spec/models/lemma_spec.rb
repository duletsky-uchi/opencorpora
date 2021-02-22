require 'rails_helper'

RSpec.describe Lemma, type: :model do
  let(:lemma) { create :lemma }

  it('build') { expect(build(:lemma, kind_id)).to be_valid() }
  it('create') { expect(create(:lemma)).to be_valid() }

end
