# typed: false
require 'spec_helper'
require 'rails_helper'


describe RootController do
  describe '#index' do
    subject! do
      get :index
    end

    it { is_expected.to have_http_status(:success) }
  end
end
