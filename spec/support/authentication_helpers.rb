module Requests
  module AuthenticationHelpers
    def each_auth_adapter(&block)
      %w[headers jwt].each do |authentication|
        describe "with #{authentication} authentication" do
          before do
            allow(ENV).to receive(:fetch).with('AUTHENTICATION_METHOD').and_return(authentication)

            if authentication == 'jwt'
              allow(ENV).to receive(:fetch).with('DATA_CACHE').and_return('1')
            end
          end

          context('example', &block)
        end
      end
    end
  end
end
