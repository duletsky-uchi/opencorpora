# typed: false
require 'spec_helper'
require 'rails_helper'

describe Api::V1::GramemesByFormController do

  describe '#show' do

    context 'when data exists' do
      subject do
        lemma_grammeme
        get :show, params: params
        json['grammemes'].first
      end

      let(:text) { 'бежала'  }
      let(:params) { { form: text } }
      let(:grammema) { create :grammeme }
      let(:lemma_form) { create :lemma_form, text: text }
      let(:lemma_grammeme) { create :lemma_grammeme, kind_type: 'LemmaForm', kind_id: lemma_form.id, grammeme_id: grammema.id }

      its(['lemma_id']) { is_expected.to eq lemma_form.lemma_id }
      its(['name']) { is_expected.to eq grammema.name }
      its(['alias']) { is_expected.to eq grammema.alias }
      its(['description']) { is_expected.to eq grammema.description }
    end

    context 'when success' do
      subject! { get :show, params: params }

      let(:params) { { form: 'бежала' } }

      it { is_expected.to have_http_status(:success) }
      it { expect(json['grammemes']).to eq [] }
    end

    context 'when empty_form' do
      subject { get :show, params: params }

      let(:params) { { form: '' } }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end

    context 'when empty_form' do
      subject { get :show, params: params }

      let(:params) { { form: '' } }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end
end
