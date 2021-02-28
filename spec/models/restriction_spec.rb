require 'rails_helper'

RSpec.describe Restriction, type: :model do
  it('build') { expect(build(:restriction)).to be_valid() }
  it('create') { expect(create(:restriction)).to be_valid() }
end
