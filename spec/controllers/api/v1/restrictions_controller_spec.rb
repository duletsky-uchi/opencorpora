# typed: false
require 'spec_helper'
require 'rails_helper'

describe Api::V1::RestrictionsController do
  describe '#show' do

    context 'when success' do
      subject! { get :show, params: params }

      let(:params) { { id: restriction.id } }
      let(:restriction) { create(:restriction) }

      it { is_expected.to have_http_status(:success) }
    end

    context 'when empty_restriction' do
      subject { get :show, params: params }

      let(:params) { { id: Uniqid.p } }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  context 'when data exists' do
    subject do
      restriction
      get :show, params: params
      json['restriction']
    end

    let(:text) { 'бежала' }
    let(:params) { { id: restriction.id } }
    let(:restriction) { create(:restriction) }

    its(['id']) { is_expected.to eq restriction.id }
    its(['typ']) { is_expected.to eq restriction.typ }
    its(['auto']) { is_expected.to eq restriction.auto }
    its(['left_type']) { is_expected.to eq restriction.left_type }
    its(['left_grammeme_id']) { is_expected.to eq restriction.left_grammeme_id }
    its(['right_type']) { is_expected.to eq restriction.right_type }
    its(['right_grammeme_id']) { is_expected.to eq restriction.right_grammeme_id }
  end

end
