# typed: false
require 'spec_helper'
require 'rails_helper'

describe Api::V1::PingController do

  describe '#index' do
    subject! do
      get :index
      OpenStruct.new(JSON.parse(response.body))
    end

    its(:ping) { should eq 'pong' }
  end
end
