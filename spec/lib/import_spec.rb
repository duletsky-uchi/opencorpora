require 'rails_helper'

RSpec.describe ::Import do

  describe '#inc' do
    subject! { Import.call "#{Rails.root}/spec/fixtures/dic.xml", log: false }

    it { is_expected.to be true }
    it { expect(Link.count).to eq 2 }
    it { expect(LinkType.count).to eq 27 }
    it { expect(Lemma.count).to eq 6 }
    it { expect(LemmaText.count).to eq 6 }
    it { expect(LemmaForm.count).to eq 62 }
    it { expect(LemmaGrammeme.count).to eq 183 }
    it { expect(Restriction.count).to eq 385 }
  end
end
