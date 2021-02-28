# typed: false
require 'spec_helper'
require 'rails_helper'

describe Api::V1::LinkTypesController do
  describe '#show' do

    context 'when success' do
      subject! { get :show, params: params }

      let(:params) { { id: link_type.id } }
      let(:link_type) { create(:link_type) }

      it { is_expected.to have_http_status(:success) }
    end

    context 'when empty_link_type' do
      subject { get :show, params: params }

      let(:params) { { id: Uniqid.p } }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  context 'when data exists' do
    subject do
      link_type
      get :show, params: params
      json['link_type']
    end

    let(:text) { 'бежала' }
    let(:params) { { id: link_type.id } }
    let(:link_type) { create(:link_type) }

    its(['id']) { is_expected.to eq link_type.id }
    its(['name']) { is_expected.to eq link_type.name }
  end

end
