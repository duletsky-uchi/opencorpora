RSpec.configure do |config|
  config.after(:each) do
    ENV['UCHI_API_URL'] = nil
  end
end
