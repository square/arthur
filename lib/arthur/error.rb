require_relative 'api'

module Arthur
  class Error
    def self.fetch(error_id)
      Arthur::Error.new(Arthur::Api.get("/errors/#{error_id}"))
    end

    attr_reader :data

    def initialize(data)
      @data = data
    end

    def count_in_environment(env)
      @data['release_stages'].fetch(env, 0)
    end
  end
end
