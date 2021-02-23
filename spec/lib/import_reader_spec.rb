require 'rails_helper'

RSpec.describe ::ImportReader do

  describe '#inc' do
    subject! { ImportReader.call "#{Rails.root}/spec/fixtures/dic.xml", log: false }

    it { is_expected.to be true }
    it {
      expect(Link.count).to eq 2
      expect(LinkType.count).to eq 27
      expect(Lemma.count).to eq 6
      expect(LemmaText.count).to eq 6
      expect(LemmaForm.count).to eq 62
      expect(LemmaGrammeme.count).to eq 183
      expect(Restriction.count).to eq 385
    }
    it {
      expect(Link.first.typ).to eq '1'
      expect(LinkType.first.name).to eq 'ADJF-ADJS'
      expect(Lemma.first.lemma_id).to eq 1
      expect(Lemma.first.rev).to eq 1
      expect(LemmaText.first.text).to eq 'ёж'
      expect(LemmaGrammeme.first.kind_type).to eq 'LemmaText'
      expect(Restriction.first.typ).to eq 'obligatory'
      expect(Restriction.first.auto).to eq false
      expect(Restriction.first.left_type).to eq 'lemma'
      expect(Restriction.first.right_type).to eq 'lemma'
    }
  end
end
