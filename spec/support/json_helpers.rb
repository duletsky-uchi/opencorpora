module Requests
  module JsonHelpers
    def json
      @json ||= JSON.parse(response.body)
    end

    def jsons
      @json ||= JSON.parse(response.body).deep_symbolize_keys
    end

    def jsono
      @jsono ||= OpenStruct.new(JSON.parse(response.body))
    end

    def jsonos
      @jsono ||= OpenStruct.new(JSON.parse(response.body).deep_symbolize_keys)
    end
  end
end
