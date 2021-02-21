module ActiveStorageHelpers
  # https://bloggie.io/@kinopyo/7-practical-tips-for-activestorage-on-rails-5-2
  # ported from https://github.com/rails/rails/blob/4a17b26c6850dd0892dc0b58a6a3f1cce3169593/activestorage/test/test_helper.rb#L52
  def create_file_blob(filename: "image.svg", content_type: "image/svg+xml", metadata: nil)
    ActiveStorage::Blob.create_after_upload! io: file_fixture(filename).open, filename: filename, content_type: content_type, metadata: metadata
  end
end

RSpec.configure do |config|
  config.include ActiveStorageHelpers
end
