require 'rails_helper'

RSpec.describe Grammeme, type: :model do
  let(:grammeme) { create :grammeme }

  it('build') { expect(build(:grammeme)).to be_valid() }
  it('create') { expect(create(:grammeme)).to be_valid() }
end
