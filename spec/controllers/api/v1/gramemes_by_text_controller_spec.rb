# typed: false
require 'spec_helper'
require 'rails_helper'

describe Api::V1::GramemesByTextController do

  describe '#show' do

    context 'when data exists' do
      subject do
        lemma_grammeme
        get :show, params: params
        json['grammemes'].first
      end

      let(:text) { 'бежала' }
      let(:params) { { text: text } }
      let(:grammema) { create :grammeme }
      let(:lemma_text) { create :lemma_text, text: text }
      let(:lemma_grammeme) do
        create :lemma_grammeme,
               kind_type: 'LemmaText',
               kind_id: lemma_text.id,
               grammeme_id: grammema.id
      end

      its(['lemma_id']) { is_expected.to eq lemma_text.lemma_id }
      its(['name']) { is_expected.to eq grammema.name }
      its(['alias']) { is_expected.to eq grammema.alias }
      its(['description']) { is_expected.to eq grammema.description }
    end

    context 'when data some texts' do
      subject do
        lemma_grammeme1
        lemma_grammeme2
        lemma_grammeme3
        get :show, params: params
        json
      end

      let(:text) { 'бежала' }
      let(:params) { { text: text } }

      let(:grammema1) { create :grammeme }
      let(:grammema2) { create :grammeme }
      let(:lemma_text1) { create :lemma_text, text: text }
      let(:lemma_grammeme1) do
        create :lemma_grammeme,
               kind_type: 'LemmaText',
               kind_id: lemma_text1.id,
               grammeme_id: grammema1.id
      end
      let(:lemma_grammeme2) do
        create :lemma_grammeme,
               kind_type: 'LemmaText',
               kind_id: lemma_text2.id,
               grammeme_id: grammema2.id
      end

      let(:lemma_text2) { create :lemma_text, text: text }
      let(:lemma_grammeme3) do
        create :lemma_grammeme,
               kind_type: 'LemmaText',
               kind_id: lemma_text2.id,
               grammeme_id: grammema1.id
      end

      it { expect(subject.size).to eq 1 }
      it { expect(subject['grammemes'].first['lemma_id']).to eq lemma_text1.lemma_id }
    end

    context 'when success' do
      subject! { get :show, params: params }

      let(:params) { { text: 'бежала' } }

      it { is_expected.to have_http_status(:success) }
      it { expect(json['grammemes']).to eq [] }
    end

    context 'when empty_form' do
      subject { get :show, params: params }

      let(:params) { { text: '' } }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end

    context 'when empty_form' do
      subject { get :show, params: params }

      let(:params) { { text: '' } }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end
end
