# Вспомогательный метод чтения JSON схем и интеграции их в swagger-ui

def read_from(*file_path)
  file_path = './spec/support/api/schemas/b2t/' << file_path.join('/') << '.json'
  JSON.parse(File.read(file_path), symbolize_names: true)
rescue Errno::ENOENT
  pp "Schema #{file_path} was not found"
  nil
rescue JSON::ParserError
  pp "Schema #{file_path} cannot be parsed"
  nil
end
