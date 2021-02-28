# typed: false
require 'spec_helper'
require 'rails_helper'

describe Api::V1::LemmaFormsController do
  describe '#show' do

    context 'when success' do
      subject! { get :show, params: params }

      let(:params) { { id: lemma_form.id } }
      let(:lemma_form) { create(:lemma_form) }

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
      json['lemma_form']
    end

    let(:params) { { id: lemma_form.id } }
    let(:text) { 'бежала' }
    let(:lemma) { create(:lemma) }
    let(:grammeme) { create(:grammeme) }
    let(:lemma_form) { create :lemma_form, text: text, lemma: lemma }
    let(:lemma_grammeme) do
      create :lemma_grammeme,
             kind_type: 'LemmaForm',
             kind_id: lemma_form.id,
             grammeme_id: grammeme.id
    end

    its(['id']) { is_expected.to eq lemma_form.id }
    its(['text']) { is_expected.to eq lemma_form.text }
    its(['lemma_id']) { is_expected.to eq lemma_form.lemma_id }
  end

end
