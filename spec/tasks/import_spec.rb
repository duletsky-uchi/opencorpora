require 'rails_helper'

RSpec.describe 'rake import:xml', type: :task do

  context 'when no data' do
    let(:text) { /Xml imported/ }

    it { expect { task.execute }.to output(text).to_stdout }
  end

  context 'when data exists' do
    let(:text) { 'бежала'  }
    let(:params) { { form: text } }
    let(:grammema) { create :grammeme }
    let(:lemma_form) { create :lemma_form, text: text }
    let(:lemma_grammeme) { create :lemma_grammeme, kind_type: 'LemmaForm', kind_id: lemma_form.id, grammeme_id: grammema.id }

    before { lemma_grammeme }

    it { expect { task.execute }.to output(text).to_stdout }
  end
end
