# typed: false
require 'spec_helper'
require 'rails_helper'

describe Api::V1::LemmasByGramemesController do
  describe '#show' do

    context 'when data exists' do
      subject do
        lemma_grammeme
        get :show, params: params
        json['lemmas'].first
      end

      let(:text) { 'бежала' }
      let(:params) { { grammemes: grammeme.name } }
      let(:grammeme) { create :grammeme }
      let(:lemma) { create(:lemma) }
      let(:lemma_text) { create :lemma_text, text: text, lemma_id: lemma.id }
      let(:lemma_grammeme) do
        create :lemma_grammeme,
               kind_type: 'LemmaText',
               kind_id: lemma_text.id,
               grammeme_id: grammeme.id
      end

      its(['lemma_id']) { is_expected.to eq lemma.id }
      its(['text']) { is_expected.to eq text }
    end

    context 'when success' do
      subject! { get :show, params: params }

      let(:params) { { grammemes: 'NOUN' } }

      it { is_expected.to have_http_status(:success) }
      it { expect(json['lemmas']).to eq [] }
    end

    context 'when empty_form' do
      subject { get :show, params: params }

      let(:params) { { grammemes: ',' } }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end
end
