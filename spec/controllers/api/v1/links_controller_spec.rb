# typed: false
require 'spec_helper'
require 'rails_helper'

describe Api::V1::LinksController do
  describe '#show' do

    context 'when success' do
      subject! { get :show, params: params }

      let(:params) { { id: link.id } }
      let(:link) { create(:link) }

      it { is_expected.to have_http_status(:success) }
    end

    context 'when empty_link' do
      subject { get :show, params: params }

      let(:params) { { id: Uniqid.p } }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  context 'when data exists' do
    subject do
      link
      get :show, params: params
      json['link']
    end

    let(:text) { 'бежала' }
    let(:params) { { id: link.id } }
    let(:link) { create(:link) }

    its(['id']) { is_expected.to eq link.id }
    its(['lemma_from_id']) { is_expected.to eq link.lemma_from_id }
    its(['lemma_to_id']) { is_expected.to eq link.lemma_to_id }
    its(['type_id']) { is_expected.to eq link.type_id }
  end

end
