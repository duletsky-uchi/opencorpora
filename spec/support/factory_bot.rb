# https://stackoverflow.com/questions/33829440/undefined-method-create-rails-spec/44478404
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
