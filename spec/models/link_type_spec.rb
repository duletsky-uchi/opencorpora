require 'rails_helper'

RSpec.describe Link, type: :model do
  it('build') { expect(build(:link_type)).to be_valid() }
  it('create') { expect(create(:link_type)).to be_valid() }
end
