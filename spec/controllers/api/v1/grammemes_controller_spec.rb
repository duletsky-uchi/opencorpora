# typed: false
require 'spec_helper'
require 'rails_helper'

describe Api::V1::GrammemesController do
  describe '#show' do

    context 'when success' do
      subject! { get :show, params: params }

      let(:params) { { id: grammeme.id } }
      let(:grammeme) { create(:grammeme) }

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
      grammeme
      get :show, params: params
      json['grammeme']
    end

    let(:params) { { id: grammeme.id } }
    let(:grammeme) { create(:grammeme) }

    its(['id']) { is_expected.to eq grammeme.id }
    its(['name']) { is_expected.to eq grammeme.name }
    its(['parent']) { is_expected.to eq grammeme.parent }
    its(['alias']) { is_expected.to eq grammeme.alias }
    its(['description']) { is_expected.to eq grammeme.description }
  end

end
