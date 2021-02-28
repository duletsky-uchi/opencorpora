require 'rails_helper'

RSpec.describe Link, type: :model do
  it('build') { expect(build(:link)).to be_valid() }
  it('create') { expect(create(:link)).to be_valid() }
end
