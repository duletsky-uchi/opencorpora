# typed: false
require 'spec_helper'
require 'rails_helper'

describe Api::V1::LemmasController do
  describe '#show' do

    context 'when success' do
      subject! { get :show, params: params }

      let(:params) { { id: lemma.id } }
      let(:lemma) { create(:lemma) }

      it { is_expected.to have_http_status(:success) }
    end

    context 'when empty_lemma' do
      subject { get :show, params: params }

      let(:params) { { id: Uniqid.p } }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  context 'when data exists' do
    subject do
      lemma_grammeme
      get :show, params: params
      json['lemma']
    end

    let(:text) { 'бежала' }
    let(:params) { { id: lemma.id } }
    let(:lemma) { create(:lemma) }
    let(:grammeme) { create(:grammeme) }
    let(:lemma_text) { create :lemma_text, text: text, lemma_id: lemma.id }
    let(:lemma_grammeme) do
      create :lemma_grammeme,
             kind_type: 'LemmaText',
             kind_id: lemma_text.id,
             grammeme_id: grammeme.id
    end

    its(['id']) { is_expected.to eq lemma.id }
    its(['lemma_id']) { is_expected.to eq lemma.lemma_id }
    its(['rev']) { is_expected.to eq lemma.rev }
  end

end
